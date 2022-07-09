// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../@openzeppelin/contracts/access/Ownable.sol";

contract RecordGenerator is Ownable {
    event newRecord(uint recordId);

    struct Record {
        uint recordId;
        string name; 
        string dob;
    }

    Record[] public records;

    mapping (uint => address) recordToOwner;
    mapping (address => uint) ownerRecordCount;

    function getRecordByOwner(address _owner) external view returns(uint[] memory) {
        uint[] memory result = new uint[](ownerRecordCount[_owner]);
        uint counter = 0;
        for (uint i=0; i<records.length; i++) {
            if (recordToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function createRecord(string memory _name, string memory _dob) public {
        require(ownerRecordCount[msg.sender] == 0);
        records.push(Record(records.length, _name, _dob));
        uint id = records.length - 1;
        recordToOwner[id] = msg.sender;
        ownerRecordCount[msg.sender]++;
        emit newRecord(id);
    }
}