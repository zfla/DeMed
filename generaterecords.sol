pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol";

contract generateRecord is Ownable {
    event newRecord(uint recordId);

    struct Record {
        uint recordId;
        string name; 
        string dob;
    }

    Record[] public records;

    mapping (uint => address) recordToOwner;

    function getRecordByOwner(address _owner) external view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerRecordCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < records.length; i++) {
            if (recordToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function createRecord(string memory _name, string memory _dob) public {
        require(ownerRecordCount[msg.sender] == 0);
        uint x = records.push(records.length, _name, _dob);
        recordToOwner[x] = msg.sender;
        ownerRecordCount[msg.sender]++;
        emit newRecord(uint records.length);
    }
}