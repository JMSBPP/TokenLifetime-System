// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

interface ILifetimeHooks {
    function beforeBorn() external;
    function afterBorn() external;
    function beforeExpire() external;
    function afterExpire() external;
}
