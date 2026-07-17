# Distributed DBMS: Architecture, Concurrency, and Consistency

- [Distributed DBMS: Architecture, Concurrency, and Consistency](#distributed-dbms-architecture-concurrency-and-consistency)
  - [Rationale and Foundational Concepts](#rationale-and-foundational-concepts)
  - [Core Architectural Models](#core-architectural-models)
    - [Data Replication](#data-replication)
    - [Data Partitioning](#data-partitioning)
  - [The CAP Theorem](#the-cap-theorem)
    - [Consistency Levels](#consistency-levels)
    - [Availability and High Availability](#availability-and-high-availability)
    - [Partition Tolerance](#partition-tolerance)
  - [Distributed Transactions and Concurrency](#distributed-transactions-and-concurrency)
    - [Distributed Transactions](#distributed-transactions)
    - [Concurrency Control](#concurrency-control)
    - [Query Processing](#query-processing)


## Rationale and Foundational Concepts

- Vertical Scaling
- High Availability
- Disaster Recovery
- Cluster

## Core Architectural Models

### Data Replication
* Master-Slave Protocols
* Synchronous vs. Asynchronous

### Data Partitioning 

- Sharding
- Horizontal Partitioning
- Vertical Partitioning
- Sharding Key




## The CAP Theorem

In a distributed system, you can only choose two of the following three guarantees at the same time:
1. Consistency (C) 
2. Availability (A) 
3. Partition Tolerance (P)


### Consistency Levels
- Strong Consistency
- Bounded Staleness
- Weak Consistency


### Availability and High Availability


- Mean Time Between Failures (MTFB)
- Mean Time To Recover (MTTR)

$$
Availability = \frac{MTBF}{MTFB + MTTR}
$$

- The principle of "Nines"
  - Two Nines
  - Three Nines
  - Five Nines

### Partition Tolerance

- AP Systems
- CP Systems


## Distributed Transactions and Concurrency

### Distributed Transactions
* Two-Phase Commit (2PC)
  * Prepare
  * Commit

### Concurrency Control
* Multi-Version Concurrency Control (MVCC)

### Query Processing
* Signal