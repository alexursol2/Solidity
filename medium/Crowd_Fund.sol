// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IERC20} from "sce/sol/IERC20.sol";

contract CrowdFund {
    event Launch(
        uint256 id,
        address indexed creator,
        uint256 goal,
        uint32 startAt,
        uint32 endAt
    );
    event Cancel(uint256 id);
    event Pledge(uint256 indexed id, address indexed caller, uint256 amount);
    event Unpledge(uint256 indexed id, address indexed caller, uint256 amount);
    event Claim(uint256 id);
    event Refund(uint256 id, address indexed caller, uint256 amount);

    struct Campaign {
        // Creator of campaign
        address creator;
        // Amount of tokens to raise
        uint256 goal;
        // Total amount pledged
        uint256 pledged;
        // Timestamp of start of campaign
        uint32 startAt;
        // Timestamp of end of campaign
        uint32 endAt;
        // True if goal was reached and creator has claimed the tokens.
        bool claimed;
    }

    IERC20 public immutable token;
    // Total count of campaigns created.
    // It is also used to generate id for new campaigns.
    uint256 public count;
    // Mapping from id to Campaign
    mapping(uint256 => Campaign) public campaigns;
    // Mapping from campaign id => pledger => amount pledged
    mapping(uint256 => mapping(address => uint256)) public pledgedAmount;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function launch(uint256 goal, uint32 startAt, uint32 endAt) external {
        require(startAt >= block.timestamp, "start at < now");
        require(endAt >= startAt, "end at < start at");
        require(endAt <= block.timestamp + 90 days, "end at > max duration");

        count += 1;
        campaigns[count] = Campaign({
            creator: msg.sender,
            goal: goal,
            pledged: 0,
            startAt: startAt,
            endAt: endAt,
            claimed: false
        });

        emit Launch(count, msg.sender, goal, startAt, endAt);
    }

    function cancel(uint256 id) external {
        Campaign memory campaign = campaigns[id];
        require(campaign.creator == msg.sender, "not creator");
        require(block.timestamp < campaign.startAt, "started");

        delete campaigns[id];
        emit Cancel(id);
    }

    function pledge(uint256 id, uint256 amount) external {
        Campaign storage campaign = campaigns[id];
        require(block.timestamp >= campaign.startAt, "not started");
        require(block.timestamp <= campaign.endAt, "ended");

        campaign.pledged += amount;
        pledgedAmount[id][msg.sender] += amount;
        token.transferFrom(msg.sender, address(this), amount);

        emit Pledge(id, msg.sender, amount);
    }

    function unpledge(uint256 id, uint256 amount) external {
        Campaign storage campaign = campaigns[id];
        require(block.timestamp <= campaign.endAt, "ended");

        campaign.pledged -= amount;
        pledgedAmount[id][msg.sender] -= amount;
        token.transfer(msg.sender, amount);

        emit Unpledge(id, msg.sender, amount);
    }

    function claim(uint256 id) external {
        Campaign storage campaign = campaigns[id];
        require(campaign.creator == msg.sender, "not creator");
        require(block.timestamp > campaign.endAt, "not ended");
        require(campaign.pledged >= campaign.goal, "pledged < goal");
        require(!campaign.claimed, "claimed");

        campaign.claimed = true;
        token.transfer(campaign.creator, campaign.pledged);

        emit Claim(id);
    }

    function refund(uint256 id) external {
        Campaign memory campaign = campaigns[id];
        require(block.timestamp > campaign.endAt, "not ended");
        require(campaign.pledged < campaign.goal, "pledged >= goal");

        uint256 bal = pledgedAmount[id][msg.sender];
        pledgedAmount[id][msg.sender] = 0;
        token.transfer(msg.sender, bal);

        emit Refund(id, msg.sender, bal);
    }
}
