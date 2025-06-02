// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../../src/types/Epoch.sol";
import {Test} from "forge-std/Test.sol";

contract EpochTest is Test {
    using EpochLibrary for Epoch;
    function setup() public {}

    function test__toEpoch() external view {
        //        2               |          0              |        213                |       426    |
        // 2 BLOCKS OF DISTANCE  |  EPOCH_TYPE BLOCK_BASED   |   STARTING AT BLOCK 213   |   ENDING AT BLOCK 426
        uint32 spacing = 2;
        IERC7818.EPOCH_TYPE blockBased = IERC7818.EPOCH_TYPE.BLOCKS_BASED;
        uint88 initialEpoch = 213;
        uint88 lastEpoch = 426;
        uint256 expectedEpoch = uint256(uint8(spacing)) |
            (uint256(uint8(blockBased)) << 32) |
            (uint256(initialEpoch) << 40) |
            (uint256(lastEpoch) << 128);
        Epoch epoch = toEpoch(spacing, blockBased, initialEpoch, lastEpoch);
        assertEq(Epoch.unwrap(epoch), expectedEpoch);

        // From the constructed epoch, we want to test
        // the unpocking of each of the values that form
        // the epoch. This is:

        uint32 resEpochSpacing = epoch.getSpacing();
        assertEq(resEpochSpacing, spacing);
        IERC7818.EPOCH_TYPE resEpochType = epoch.getType();
        assertEq(uint8(resEpochType), uint8(blockBased));

        uint88 resLowerBound = epoch.getLowerBound();
        assertEq(resLowerBound, initialEpoch);
        uint88 resUpperBound = epoch.getUpperBound();
        assertEq(resUpperBound, lastEpoch);
    }
}
