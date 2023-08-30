// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Coffee {
    // Address of the contract deployer.
    address payable owner;

    // Event to emit when a Memo is created.
    event NewMemo(
        address indexed from,
        uint timestamp,
        string name,
        string message
    );

    // Memo struct
    struct Memo { 
        address from;
        uint timestamp;
        string name;
        string message;
    }

    // List of all memos received from friends.
    Memo[] memos;

    // Deploy contract logic.
    constructor() {
        owner = payable(msg.sender);
    }

    /**
     * @dev Buy a coffee for contract owner
     * @param _name name of the coffee buyer
     * @param _message A nice message from the coffee buyer
     */

    function buyCoffee(
        string memory _name,
        string memory _message
    ) public payable {
        require(msg.value > 0, "Can't buy a coffee for 0 ETH");

        // Add the memo to storage.
        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        // Emit a log event when a new memo is created.
        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    /**
     * @dev Send the entire balance stored in this contract to the owner.
     */

    function withdrawTips () public {
        // We're here fetching the address of this contract.
        require(owner.send(address(this).balance));
    }

    /**
     * @dev Retrieve all the memos stored on the blockchain.
     */

    function getMemos () public view returns (Memo[] memory){
        return memos;
    }
}
