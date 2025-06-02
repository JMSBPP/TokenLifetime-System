// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../interfaces/IERC7818.sol";

type Epoch is uint256;

using EpochLibrary for Epoch global;
using BoundsLibrary for uint72;

// spacing | EPOCH_TYPE | initial_epoch | last_epoch | currentEpoch |
//  uint32  |  uint8     |   uint72      | uint72     |  uint72      |
//          40
//        2               |          0              |        213                |       426    |
// 2 BLOCKS OF DISTANCE  |  EPOCH_TYPE BLOCK_BASED   |   STARTING AT BLOCK 213   |   ENDING AT BLOCK 426
// 20213426
error Epoch___epochsArenotLinearyOperable();
error Bounds__InvalidBoundParams();


struct EpochParams{
    uint32 spacing;
    IERC7818.EPOCH_TYPE epochType;
    uint72 lowerEpochBound;
    uint72 upperEpochBound;
    uint72 currentEpoch
}
library EpochParamsLibrary {
    function     
}
function toEpoch(
    uint32 spacing,
    IERC7818.EPOCH_TYPE epochType,
    uint72 lowerEpochBound,
    uint72 upperEpochBound,
    uint72 currentEpoch
) view returns (Epoch epoch) {
    if (
        !(validEpochParams(spacing ))
    ) revert Bounds__InvalidBoundParams();

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
function addable(Epoch e1, Epoch e2) pure returns (bool areAddable) {
    areAddable = (e1.getType() == e2.getType() &&
        e1.getSpacing() == e2.getSpacing());
}

function substractabe(Epoch e1, Epoch e2) view returns (bool areSubstractable) {
    areSubstractable = (addable(e1, e2) &&
        uint88(e1.getLowerBound() - e2.getLowerBound()).validLowerBound());
}

function add(Epoch e1, Epoch e2) view returns (Epoch e1Pluse2) {
    if (!addable(e1, e2)) revert Epoch___epochsArenotLinearyOperable();
    e1Pluse2 = toEpoch(
        e1.getSpacing(),
        e1.getType(),
        uint88(e1.getLowerBound() + e2.getLowerBound()),
        uint88(e1.getUpperBound() + e2.getUpperBound())
    );
}

function sub(Epoch e1, Epoch e2) view returns (Epoch e1Minus2) {
    if (!substractabe(e1, e2)) revert Epoch___epochsArenotLinearyOperable();
    e1Minus2 = toEpoch(
        e1.getSpacing(),
        e1.getType(),
        uint88(e1.getLowerBound() - e2.getLowerBound()),
        uint88(e1.getUpperBound() - e2.getUpperBound())
    );
}
function eq(Epoch e1, Epoch e2) pure returns (bool areEqual) {
    areEqual =
        addable(e1, e2) &&
        e1.getLowerBound() == e2.getLowerBound() &&
        e1.getUpperBound() == e2.getUpperBound();
}

function neq(Epoch e1, Epoch e2) pure returns (bool areNotEqual) {
    areNotEqual = !eq(e1, e2);
}

library EpochLibrary {
    /**
     * @notice Retrieves the epoch spacing value from a packed Epoch.
     * @dev Extracts the lowest 32 bits (bits 0-31) from the packed Epoch value,
     *      which represent the spacing between epochs (e.g., in blocks or seconds).
     * @param epoch The packed Epoch value.
     * @return epochSpacing The spacing value as a uint8.
     */

    function getSpacing(
        Epoch epoch
    ) internal pure returns (uint32 epochSpacing) {
        epochSpacing = uint32(Epoch.unwrap(epoch) & 0xFFFFFFFF);
    }
    /**
     * @notice Retrieves the epoch type from a packed Epoch.
     * @dev Extracts bits 32-39 from the packed Epoch value, which represent the EPOCH_TYPE
     *      (e.g., BLOCKS_BASED or TIME_BASED as defined in IERC7818).
     * @param epoch The packed Epoch value.
     * @return epochType The epoch type as an IERC7818.EPOCH_TYPE enum value.
     */
    function getType(
        Epoch epoch
    ) internal pure returns (IERC7818.EPOCH_TYPE epochType) {
        uint8 _epochType;
        assembly ("memory-safe") {
            _epochType := and(shr(32, epoch), 0xFF)
        }
        epochType == IERC7818.EPOCH_TYPE(_epochType);
    }

    /**
     * @notice Retrieves the lower epoch bound from a packed Epoch.
     * @dev Extracts 88 bits from position 40 to 127 (inclusive) from the packed Epoch value.
     *      Shifts right by 40 bits, then masks the lowest 88 bits to obtain the lower bound.
     * @param epoch The packed Epoch value.
     * @return lowerEpochBound The lower epoch bound as a uint88.
     */
    function getLowerBound(
        Epoch epoch
    ) internal pure returns (uint88 lowerEpochBound) {
        lowerEpochBound = uint88((Epoch.unwrap(epoch) >> 40) & ((1 << 88) - 1));
    }

    /**
     * @notice Retrieves the upper epoch bound from a packed Epoch.
     * @dev Extracts 88 bits from position 128 to 215 (inclusive) from the packed Epoch value.
     *      Shifts right by 128 bits, then masks the lowest 88 bits to obtain the upper bound.
     * @param epoch The packed Epoch value.
     * @return upperEpochBound The upper epoch bound as a uint88.
     */
    function getUpperBound(
        Epoch epoch
    ) internal pure returns (uint88 upperEpochBound) {
        upperEpochBound = uint88(
            (Epoch.unwrap(epoch) >> 128) & ((1 << 88) - 1)
        );
    }
}
library BoundsLibrary {
    /**
     * @notice Checks if the current block number is greater than or equal to the given lower epoch bound.
     * @dev Compares the current block.number (cast to uint88) with the provided lowerEpochBound.
     *      Returns true if the current block is at or past the lower bound, false otherwise.
     * @param lowerEpochBound The lower bound of the epoch as a uint88.
     * @return isValid True if the current block number is >= lowerEpochBound, false otherwise.
     */
    function validLowerBound(
        uint88 lowerEpochBound
    ) internal view returns (bool isValid) {
        isValid = uint88(block.number) >= lowerEpochBound;
    }

    /**
     * @notice Checks if the upper epoch bound is valid relative to the lower bound and spacing.
     * @dev Returns true if upperEpochBound is greater than lowerEpochBound and the difference
     *      between them is an exact multiple of spacing. This ensures the bounds are properly aligned.
     * @param upperEpochBound The upper bound of the epoch as a uint88.
     * @param lowerEpochBound The lower bound of the epoch as a uint88.
     * @param spacing The spacing between epochs as a uint32.
     * @return isValid True if the upper bound is valid, false otherwise.
     */
    function validUpperBound(
        uint88 upperEpochBound,
        uint88 lowerEpochBound,
        uint32 spacing
    ) internal pure returns (bool isValid) {
        isValid = (upperEpochBound > lowerEpochBound &&
            (upperEpochBound - lowerEpochBound) % spacing == 0);
    }
}
