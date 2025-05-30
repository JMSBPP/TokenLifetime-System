// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../interfaces/IERC7818.sol";

type Epoch is uint256;

using EpochLibrary for Epoch global;
// spacing | EPOCH_TYPE | initial_epoch | last_epoch
//  uint8    |    uint8      |   uint88            | uint88

//        2               |          0              |        213                |       426    |
// 2 BLOCKS OF DISTANCE  |  EPOCH_TYPE BLOCK_BASED   |   STARTING AT BLOCK 213   |   ENDING AT BLOCK 426
// 20213426

function toEpoch(
    uint32 spacing,
    IERC7818.EPOCH_TYPE epochType,
    uint88 lowerEpochBound,
    uint88 upperEpochBound
) pure returns (Epoch epoch) {
    assembly ("memory-safe") {
        epoch := or(
            or(
                or(and(spacing, 0xFF), shl(32, epochType)),
                shl(40, lowerEpochBound)
            ),
            shl(128, upperEpochBound)
        )
    }
}
// ADDING
// - [e1.epochType == e2.epochType ^ e1.spacing == e2.spacing]e1 + e2 = e1I + e2I & e1F + e2F
// SUBSTRACTING

// - [e1.epochType == e2.epochType ^ e1.spacing == e2.spacing]
//  ^ []
//  e1 - e2 = e1I + e2I & e1F + e2F

library EpochLibrary {
    function validEpoch(
        Epoch epoch
    ) internal pure returns (bool isValidEpoch) {}

    function getEpochLowerBound(
        Epoch epoch
    ) internal pure returns (uint88 lowerEpochBound) {}

    function getEpochUpperBound(
        Epoch epoch
    ) internal pure returns (uint88 upperEpochBound) {}
}
