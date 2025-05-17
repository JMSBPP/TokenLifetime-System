// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

struct EpochLength {
    uint256 start;
    uint256 delta;
}

library EpochLengthLib {
    function getEpochLengthBoundary(
        EpochLength storage self
    ) internal view returns (uint256) {
        return self.start + self.delta;
    }

    function setEpochLength(
        EpochLength storage self,
        uint256 start,
        uint256 delta
    ) internal {
        self.start = start;
        self.delta = updateDelta();
    }

    //TODO:
    //1. Who has the permissions (clients) to update delta?
    //2. What a re the parms of the function?
    //2.1 eacch param is a collobaroptr to the service of updatintg delta
    //2.2 What information from the client does each colaborator needs?
    // THOSE ARE THE PARAMS OF THE FUNCTION
    function updateDelta() internal returns (uint256) {}
}
