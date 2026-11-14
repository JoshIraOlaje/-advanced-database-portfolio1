# CampusFlow: University Course Registration System

## Course and Student

- Course: MIT 8103 — Advanced Database Systems
- Assessment: Individual Practical Database Portfolio
- Academic session: 2026/2027
- Student: Joshua Olaje
- Student ID: 301908840

## Case Study

CampusFlow is a simulated university course registration system.
All sample and benchmark records are synthetic.

The relational database stores departments, students, lecturers,
courses, academic terms, course offerings and registrations.

The project demonstrates database design, SQL reporting and
optimisation, transactions, concurrency control, a MongoDB
document model and a proposed distributed/cloud architecture.

## Database Users

- Registry staff maintain academic records and course offerings.
- Students register for courses and view their registrations.
- Lecturers view class lists and record grades.
- Database administrators manage database access and operations.

These describe the intended users. A user interface, authentication
system and production access-control configuration were not built.

## Implemented Operations

- Create related academic records.
- Offer courses during specific academic terms.
- Prevent duplicate student-offering registrations.
- Record grades and retrieve academic records.
- Generate enrolment and student academic reports.
- Register students through a transaction that checks capacity.
- Store, query and update student term documents in MongoDB.

Capacity enforcement depends on using the approved registration
procedure. Unrestricted direct inserts can bypass that check.

## Portfolio Navigation

| Portfolio | Contents |
|---|---|
| [1. Database design](portfolio-1-database-design/) | Business rules, ER diagram, relational schema, normalisation, table creation and constraint tests |
| [2. Query optimisation](portfolio-2-query-optimisation/) | Reports, execution plans, benchmark data and indexing analysis |
| [3. Transactions and concurrency](portfolio-3-transactions-concurrency/) | Commit, rollback, isolation, row locking and registration procedure |
| [4. NoSQL](portfolio-4-nosql/) | MongoDB documents, embedded-course queries, grade update and modelling discussion |
| [5. Distributed/cloud](portfolio-5-distributed-cloud/) | Proposed replication, consistency, availability, sharding and recovery design |

Each portfolio README explains its files, implementation steps,
evidence and limitations.

## Technologies Used

- MySQL Community Server 8.0.46.
- InnoDB storage engine.
- MySQL Workbench.
- MongoDB Community Server.
- MongoDB Compass and its embedded MongoDB shell.
- Windows 11.
- GitHub for version history and portfolio organisation.

## Implementation and Findings

### Portfolio 1: Database Design

Seven related tables were implemented.

The initial dataset contained:
- 3 departments.
- 6 students.
- 3 lecturers.
- 4 courses.
- 2 academic terms.
- 4 course offerings.
- 8 registrations.

The design was explained to Third Normal Form under its stated
business rules.

Manual tests confirmed rejection of duplicate registrations,
an out-of-range grade, a nonexistent department reference
and a NULL required first name.

### Portfolio 2: Query Optimisation

Enrolment and student academic reports were implemented.

A further 10,000 synthetic students were added, producing
10,006 students for the indexing experiment.

The captured surname-search executions showed:

| Measure | Before index | After index |
|---|---:|---:|
| Access method | Table scan | Index lookup |
| Actual rows returned by scan or lookup | 10,006 | 10 |
| Final matching rows | 10 | 10 |
| Top-level EXPLAIN ANALYZE completion time | 4.79 ms | 0.0777 ms |

The observed time reduction was approximately 98.38%.

These figures compare individual captured executions, not
repeated-run averages. They do not establish the same improvement
for other queries or workloads.

### Portfolio 3: Transactions and Concurrency

The exercises demonstrated:
- Cancellation of an uncommitted grade change using ROLLBACK.
- Persistence of a committed change.
- Prevention of dirty reads using READ COMMITTED.
- Coordination of registration work using an offering row lock.

The register_student procedure automates offering lookup,
duplicate detection, capacity checking, insertion and commit.
Its exception handler rolls back failed transactions.

The full-offering test returned the expected rejection:
Course offering is full.

Detailed test status and evidence are recorded in Portfolio 3.

### Portfolio 4: NoSQL

Three student term documents were implemented in MongoDB.

Each document embeds department details and an array of courses.

Queries retrieved:
- All three documents.
- Ada and Bayo as students taking BIO101.
- Ada as the student with a BIO101 grade of at least 70.

Chidi's embedded CSC101 grade was updated from null to 72.

The documents are manually prepared snapshots. They are not
automatically synchronised with MySQL.

### Portfolio 5: Distributed and Cloud Design

A proposed architecture separates authoritative registration
writes from suitable replica-based reporting.

The discussion covers replication delay, consistency,
availability, failover, sharding and backup recovery.

This is a design discussion. No cloud deployment, replication,
failover or sharding implementation is claimed.

## Reproducing the Work

1. Start with Portfolio 1's database creation instructions,
   table script and initial sample-data script.
2. Run its verification queries and individual constraint tests.
3. Follow Portfolio 2's reporting and benchmark instructions.
4. Capture the surname-search baseline before creating its index.
5. Follow Portfolio 3's staged transaction exercises, alternating
   between separate connections where instructed.
6. Follow Portfolio 4's MongoDB import, query and update instructions.
7. Review Portfolio 5 as a proposed architecture.

Scripts are not all safe to rerun without checking the current state.

In particular:
- Do not repeatedly insert the same sample or benchmark data.
- Do not recreate existing tables, indexes or procedures blindly.
- Transaction exercises may change registration records.
- Run expected-error tests individually and follow cleanup instructions.
- Use a separate fresh test environment when reproducing the full
  sequence; do not delete existing work merely to restart.

## Evidence and Limitations

Scripts, screenshots, outputs and analysis are organised within
the relevant portfolio folders.

Portfolio 1 counts describe the initial dataset.
Later portfolios add benchmark students and registration examples.

Performance findings are limited to the captured local experiment.
MongoDB demonstrates a selected read-oriented model rather than
every relational operation.

Production permissions, comprehensive load tests and a deployed
distributed system remain outside the implemented scope.

## Final Documentation

The separate 2–3 page LMS report will summarise the five portfolios,
include selected evidence and this repository link, and provide
an individual reflection, references and an AI-use declaration.

Repository:
https://github.com/JoshIraOlaje/-advanced-database-portfolio1

The repository is private. Assessor access must be arranged before
submission.

## References

- MIT 8103 Advanced Database Systems assessment brief,
  2026/2027 Academic Session.
- MySQL 8.0 Reference Manual:
  https://dev.mysql.com/doc/refman/8.0/en/
- MongoDB Documentation:
  https://www.mongodb.com/docs/
- Watt, A. and Eng, N. Database Design – 2nd Edition:
  https://opentextbc.ca/dbdesign/

Specific technical references are included in the portfolio documents.

## AI-Use Declaration

OpenAI ChatGPT assisted with project planning, explanations,
SQL and MongoDB examples, troubleshooting, analysis and
documentation drafts.

I executed the practical exercises locally and checked the outputs.
Errors encountered during implementation were reviewed and corrected,
including replacing a temporary-table generator with a CTE.

The individual reflection is based on my own account of the learning
experience and was shortened with ChatGPT assistance.

I remain responsible for reviewing, understanding and explaining
the submitted work.
