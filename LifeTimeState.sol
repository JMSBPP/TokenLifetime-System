// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

struct LifetimeState {
    uint32 bornIndex;
    uint32 expireIndex; //OPTIONAL IF design does not enforce expiration from initalization
    uint256 currentEpochID;
}
