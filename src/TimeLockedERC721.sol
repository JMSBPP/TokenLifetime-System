// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ITimeLockedERC721} from "./interfaces/ITimeLockedERC721.sol";
import {IERC7818} from "./interfaces/IERC7818.sol";
abstract contract TimeLockedERC721 is ITimeLockedERC721 {
    IERC7818 private timeCommitment;
}
