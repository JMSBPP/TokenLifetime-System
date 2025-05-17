// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {ILifetimeHooks} from "./ILifetimeHooks.sol";
interface ILifetime {
    function born(ILifetimeHooks hooks) external;
    function expire(ILifetimeHooks hooks) external;
    /**
     * @dev Retrieves the latest epoch currently tracked by the lifetime state.
     * @return uint256 A pointer to the latest epoch of the lifetime state.
     */
    function currentEpoch() external view returns (uint256);
}
