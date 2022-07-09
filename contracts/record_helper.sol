// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./record_generator.sol";

contract RecordHelper is RecordGenerator {
    // we'll map an array of approved addreses to a record
    mapping (uint => address[]) recordToApproved;

    // checking if an individual running a command is approved by the user
    function Approved(uint _recordId) internal view returns(bool) {
        bool approved = false;
        for (uint i=0; i<recordToApproved[_recordId].length; i++) {
            if (recordToApproved[_recordId][i] == msg.sender) {
                approved = true;
            }
        }
        return approved;
    }

    modifier onlyApproved(uint _recordId) {
        require(msg.sender == recordToOwner[_recordId] || Approved(_recordId) == true);
        _;
    }

    modifier onlyOwnerOf(uint _recordId) {
        require(msg.sender == recordToOwner[_recordId]);
        _;
    }

    function addApproved(uint _recordId, address _approvedAddress) external onlyOwnerOf(_recordId) {
        recordToApproved[_recordId].push(_approvedAddress);
    }

}



