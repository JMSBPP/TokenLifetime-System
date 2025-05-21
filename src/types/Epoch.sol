// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "../base/Errors.sol";
struct Epoch {
    uint256 start;
    uint256 boundary;
}

library EpochLib {
    function getEpochId(Epoch storage self) internal view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(self.start, self.boundary)));
    }
    function getEpochStart(Epoch storage self) internal view returns (uint256) {
        return self.start;
    }

    function getEpochBoundary(
        Epoch storage self
    ) internal view returns (uint256) {
        return self.boundary;
    }

    // THIS SERVICE IS IMMUTABLE AND IS ONLY AVAILABLE TO THE LIFETIME
    function setEpochStart(Epoch storage self, uint256 start) internal {
        self.start = start;
    }

    function setEpochBoundary(Epoch storage self, uint256 boundary) internal {
        if (getEpochStart(self) >= boundary) {
            revert EpochBoundaryMustBeGreaterThanEpochStart();
        }
        self.boundary = boundary;
    }
}
