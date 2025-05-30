// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {IERC721Permit_v4} from "v4-periphery/src/interfaces/IERC721Permit_v4.sol";
import {IEIP712_v4} from "v4-periphery/src/interfaces/IEIP712_v4.sol";
import {IPermit2Forwarder} from "v4-periphery/src/interfaces/IPermit2Forwarder.sol";
import {IMulticall_v4} from "v4-periphery/src/interfaces/IMulticall_v4.sol";

interface ITimeLockedERC721 is
    IERC721Permit_v4,
    IEIP712_v4,
    IPermit2Forwarder,
    IMulticall_v4
{}
