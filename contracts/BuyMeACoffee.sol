// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Deployed to Goerli at 0xad857335687F428Da2A37fe74DA529057e52Bfa5

// Import this file to use console.log
import "hardhat/console.sol";

contract BuyMeACoffee {
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    Memo[] memos;
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function buyCoffee(string memory _name, string memory _memo) public payable {
        require(msg.value > 0, "You can't buy coffee with 0 eth!");
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _memo
        ));

        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _memo
        );
    }

    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }
}
