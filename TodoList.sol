pragma solidity ^0.5.0;

contract TodoList {

    struct Task {
        uint256 id;
        string content;
        bool completed;
    }
    uint256[] public idList;
    uint public idListLength = idList.length;
    mapping(uint256 => Task) public Tasks;
    address public owner;

    modifier ownerOnly() {
        require(msg.sender == owner, "Sender not authorized.");
        _;
    }

    constructor() public {
        owner = msg.sender;
        addTask("Sample task");
        addTask("Another task to be done");
    }

    function generateID(string memory _str) private pure returns (uint256) {
        // Convert string variable to bytes variable
        bytes memory stringToBytes = bytes(_str);
        // Generate unique hash via bytes variable
        return uint256(keccak256(stringToBytes));
    }
    function addTask(string memory _content) ownerOnly public {
        uint256 _id = generateID(_content);
        idList.push(_id);
        idListLength = idList.length;
        Tasks[_id] = Task(_id, _content, false);
    }

    function markTaskCompleted(uint256 _id) ownerOnly public {
        Tasks[_id].completed = true;
    }

    // Read this https://ethereum.stackexchange.com/questions/13167/are-there-well-solved-and-simple-storage-patterns-for-solidity

}