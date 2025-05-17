// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

interface ILifetimeHooks {
    function beforBorn() external;
    function afterBorn() external;
    function beforExpire() external;
    function afterExpire() external;
}
