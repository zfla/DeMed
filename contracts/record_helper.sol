pragma solidity ^0.8.0;

import "./record_generator.sol";

contract RecordHelper is RecordGenerator {
    // we'll map an array of approved addreses to a record
    mapping (uint => address[]) recordToApproved;

    // checking if an individual running a command is approved by the user
    function Approved(uint _recordId) internal view returns(bool memory) {
        bool approved = false;
        for (uint i == 0; i < recordToApproved[_recordId].length; i++) {
            if (recordToApproved[_recordId][i] == msg.sender) {
                approved = true;
            }
        }
        return approved;
    }

    modifier onlyApproved(uint _recordId) {
        require(msg.sender == recordToOwner[recordId] | Approved(_recordId) == true)
        _;
    }

    modifier onlyOwnerOf(uint _recordId) {
        require(msg.sender == recordToOwner[recordId]);
        _;
    }

    function addApproved(uint _recordId, address _approvedAddress) external onlyOwnerOf(_recordId) {eq
        recordToApproved[_recordId].push(_approvedAddress);
    }

}



/// any individual with permission given by the owner of the medical record can edit sections of the record
/// this prevents anyone from editing the person's contract, but allows some level of editability outside of the individual only 


// think of a way to point to 'encrypted' health data
// wallets act as a 'key' to unlock encrypted data

// onboarding exam grades and other certifications to a wallet??

// GENIUS. place an object at a certain place, then transactions can take place
// coordination point to use soul bound tokens (vitalik)

// value delivering systems, how they are limiting access to resources, and how they can be disaggregated