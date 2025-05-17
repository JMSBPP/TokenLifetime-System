# TokenLifetime-System

The TokenLifetime and Epoch system enables the following services and attributes for tokenized markets:

## Table Of Content

- [TokenLifetime-System](#tokenlifetime-system)
  - [Table Of Content](#table-of-content)
  - [Documentation](#documentation)
  - [Formal Specification](#formal-specification)
  - [Epochs](#epochs)
  - [Epoch Length](#epoch-length)
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
i_j \in \texttt{epoch}(i_0, \Delta^E) := \left\{\, i_0 \leq i_j \leq i_1 \,\middle|\, \Delta^E = |i_1 - i_0|,\, i_j \in \mathbb{N}_{32} \right\}
$$

- $\Delta^E(\cdots)$ is the `epoch-length` and is controlled by the parameters $\cdots$.

## Epoch Length

An epoch length has an associated epoch id and can be adjusted.

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

