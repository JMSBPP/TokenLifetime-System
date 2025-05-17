// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

//TODO: We are concerned withs storing the epochs asociated with a lifetime

// At a high level we have the following requirements:
// 0. one lifetime can have one LifeTimeEpochs
// - What is the best data structure to store the epochs?
// - What services does the LifeTimeEpochs provide?
// - How do we search for (ordered) epochs?
// - How do we move along epochs on LifetmeEpochs?
