# Portfolio 5: Distributed and Cloud Database Design

## Overview

This portfolio proposes a distributed/cloud architecture for
CampusFlow, using the discussion option permitted by the
assessment brief.

No cloud database, replication group, failover system or sharded
cluster was deployed.

## Main Document

[Distributed and cloud design](Olaje_Joshua_301908840_P5_DistributedCloudDesign.md)

The document includes an architecture diagram, case-specific
trade-offs, references and a proposed validation plan.

## Topics Covered

- A writable MySQL primary and asynchronous reporting replica.
- Authoritative capacity checks during course registration.
- Replica lag and the risk of stale availability information.
- Availability during primary failure or network partition.
- Failover precautions and a Group Replication alternative.
- Sharding options and reasons to defer implementation.
- Cloud deployment considerations and separate backups.
- Recovery objectives and proposed failure tests.
- The limits of the manually prepared MongoDB snapshots.

## Main Design Decision

Registration requests must use the authoritative MySQL primary
and the approved transactional registration procedure.

Suitable historical reports may use a replica, with replication
delay accounted for.

Sharding is deferred because the current project provides no
workload evidence that it is necessary.

## Evidence and Limitations

The architecture diagram represents a proposal.

Local MySQL and MongoDB implementations are documented in the
earlier portfolios. They are not evidence of a distributed
deployment.

Replication delay, failover time, recovery capability, cloud cost
and distributed performance have not been measured.

## How to Review

1. Read the proposed architecture and operation requirements.
2. Trace the last-place registration example through the design.
3. Review failure behaviour and consistency trade-offs.
4. Distinguish proposed tests from completed local exercises.
5. Consult the references in the main document.

## AI Assistance

ChatGPT assisted with the architecture discussion and documentation.
The student is responsible for reviewing and explaining the design.
