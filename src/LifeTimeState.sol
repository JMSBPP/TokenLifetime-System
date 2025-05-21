// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import "./types/Epoch.sol";

struct LifetimeHistory {
    uint32 bornIndex;
    uint32 expireIndex; //OPTIONAL IF design does not enforce expiration from initalization
    mapping(uint256 epochId => Epoch epoch) epochs;
}
