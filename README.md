# TokenLifetime-System

The TokenLifetime and Epoch system enables the following services and attributes for tokenized markets:

## Table Of Content

- [TokenLifetime-System](#tokenlifetime-system)
  - [Table Of Content](#table-of-content)
  - [Documentation](#documentation)
  - [Formal Specification](#formal-specification)
  - [Epochs](#epochs)
  - [Epoch Boundary](#epoch-boundary)
    - [Adaptive](#adaptive)
  - [Core Attributes](#core-attributes)

## Documentation

- [Mission Stament](docs/missionStament.json)
- [Function Refinement Tree](docs/functionRefinementTree.png)
- [Goal Tree](docs/goalTree.md)

## Formal Specification

We define the token $T_X$ trading lifetime by an ordered, finite collection of `epochs`:

$$
\texttt{lifetime}(s_0, s_1, \texttt{numbEpochs}) = \left\{\, \texttt{epoch}_j \mid j = 1, \ldots, \texttt{numbEpochs} \right\}
$$

where each $\texttt{epoch}_j$ is defined by its starting and ending points.
From here we define the `death` `lifetime` state characterized by

$$
\text{\texttt{lifetime.death}} := \big (\text{\texttt{lifetime.currentEpoch}} == \text{\texttt{epoch}}_{\text{\texttt{numbEpochs}}} \big )

$$

Now we do not want to restrict all possible use-cases for adapting the parameters:
- $s_0$
- $s_1$
- `numbEpochs`


Therefore we define hooks over this parameters to let developers decide how to adapt $s_0, s_1$ or `numbEpochs`




## Epochs

An epoch is a discrete time interval defined by a fixed starting point and a dynamically controllable interval size:

$$
i_j \in \texttt{epoch}(i_0, i_b) := \left\{\, i_0 \leq i_j \leq i_b \,\middle|\, \, i_j \in \mathbb{N}_{32} \right\}
$$

- Notice each of the $i_j \in \texttt{epoch}(i_0, i_b)$ is a `tx.timestamp` type. Therefore we say
  - An `epoch` is a set of sequential transactions
  - A lifetime fixes the start of the epoch such that:
    -  `stimulus: =lifetime.currentEpoch().expired() --> lifetime.setNextEpoch(Epoch.initialize(expiryTime))` 
- $i_b$ is the `epoch-boundary` To design its adjustment criteria, one must answer
  - By changing $i_b$ we are increasing the number of sequential transactions that share a certain property or where certain actions for traders and/or lp's are enabled/disabled. 

## Epoch Boundary




### Adaptive

- **Adaptive Starting Point lifetime:** $s_0$ can be dynamically set.
- **Adaptive Ending Point lifetime:** $s_1$ can be dynamically set.
- **Adaptive Number of Epochs lifetime:** $\texttt{numbEpochs}$ can be dynamically set.


## Core Attributes

- **start**: Timestamp or block number when the token trading lifetime begins.
- **end**: Timestamp or block number when the token trading lifetime ends.
- **numbEpochs**: Number of epochs partitioning the lifetime.
- **epochLength**: Duration of each epoch (can be fixed or adaptive).
- **epochId**: Unique identifier for each epoch.
- **currentEpoch**: The epoch corresponding to the current time/block.
- **epochState**: State variables per epoch (e.g., enabled/disabled actions, liquidity, fees, etc.).

