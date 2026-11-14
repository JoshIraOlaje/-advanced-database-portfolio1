# Portfolio 3: Transactions and Concurrency

## Overview

This portfolio demonstrates commit, rollback, transaction isolation,
row locking and capacity-controlled registration in CampusFlow.

## Environment

- MySQL Community Server 8.0.46.
- InnoDB storage engine.
- MySQL Workbench on Windows 11.
- Two separate database connections for multi-session exercises.

## Files

| File | Purpose |
|---|---|
| Olaje_Joshua_301908840_P3_RollbackDemo.sql | Demonstrate cancellation of an uncommitted grade update |
| Olaje_Joshua_301908840_P3_CommitDemo.sql | Demonstrate that a committed update persists |
| Olaje_Joshua_301908840_P3_IsolationSessionA.sql | Make an uncommitted update in Connection A |
| Olaje_Joshua_301908840_P3_IsolationSessionB.sql | Read the committed value in Connection B |
| Olaje_Joshua_301908840_P3_LockingSessionA.sql | Lock an offering and register a student |
| Olaje_Joshua_301908840_P3_LockingSessionB.sql | Request the same lock and inspect enrolment afterward |
| Olaje_Joshua_301908840_P3_OriginalCombinedProcedureAndTests.sql | Create the capacity-checking registration procedure |
| Olaje_Joshua_301908840_P3_TestRegistrationProcedure.sql | Test registration acceptance and rejection |

Supplied screenshots document selected results. Some exercise outcomes were
confirmed in conversation without a corresponding screenshot. Recovered scripts
are labelled; they are not newly generated execution evidence.

## Prerequisites

Complete Portfolio 1 and use its original eight registrations
as the starting state for the transaction exercises.

Portfolio 2 adds benchmark students but does not add registrations.

The scripts are staged demonstrations. Follow the execution order
and check the starting data before repeating them.

## 1. Rollback

Registration 1 initially had grade 78.

Inside a transaction, the grade was changed to 80.
ROLLBACK cancelled the change, and the grade returned to 78.

Observed sequence: 78 -> 80 -> 78.

## 2. Commit

The grade was changed to 80 and committed.

A subsequent ROLLBACK did not undo the committed update.
A new transaction restored the original grade of 78.

Observed sequence:
80 after COMMIT -> 80 after ROLLBACK -> 78 after restoration.

## 3. Isolation

Two connections were verified to have different CONNECTION_ID values.

Connection A changed the grade to 80 without committing.

Connection B used READ COMMITTED and a normal SELECT.
It returned the last committed grade of 78.

This demonstrated prevention of a dirty read under the tested
isolation level. Connection A's change was rolled back afterward.

This exercise does not establish that every concurrency anomaly
is prevented by READ COMMITTED.

## 4. Concurrent Registration Control

BIO101 initially had capacity 3 and two registrations.

Connection A locked offering 1 using SELECT ... FOR UPDATE.

Connection B requested the same lock. The exercise was arranged
so that A registered student 3 and committed before B continued.

After acquiring the lock, B checked enrolment rather than
inserting another registration. The intended final count was 3.

The exercise completed without reported errors on retry.
A separate screenshot of the successful lock wait and final count was not
supplied. The full-offering rejection provides supporting evidence that the
offering was full at the later procedure test.

The acceptance decision in this exercise was manual.
The stored procedure below automates that decision.

## 5. Registration Procedure

register_student accepts a student identifier and offering identifier.

It:

1. Starts a READ COMMITTED transaction.
2. Locks the selected offering.
3. Rejects a nonexistent offering.
4. Rejects a duplicate registration.
5. Counts existing registrations.
6. Rejects registration if capacity is reached.
7. Inserts and commits an accepted registration.

An exception handler rolls back the transaction and reports
the error to the caller.

Call the procedure without an existing transaction open because
it manages its own transaction.

## Procedure Test Status

| Test | Status |
|---|---|
| Procedure creation | Confirmed successful |
| CALL register_student(4, 1) | Confirmed rejected: Course offering is full |
| CALL register_student(4, 4) | Final verification screenshot confirms students 3 and 4 are registered for offering 4 |

The full-offering rejection returned MySQL error 1644.
This was an intentional application error raised by SIGNAL.

## 6. Limitations

All registration operations must lock the offering before checking
capacity. Direct inserts can bypass the procedure's capacity check.

Database permissions have not been configured to require use
of the procedure.

Changes to offering capacity must also preserve the rule that
capacity cannot fall below existing enrolment.

The procedure has not yet been tested for every error path,
deadlock scenario or high-concurrency workload.

## 7. Troubleshooting

An initial attempt in Connection B returned error 2013:
Lost connection to MySQL server during query, after 30 seconds.

This was consistent with Workbench's documented default
30-second connection read timeout while waiting for a result.
The exact cause was not independently confirmed.

The open transaction was rolled back, B was reconnected,
and enrolment was checked before retrying.

The exercise was repeated with commands prepared in advance
so A could release its lock promptly.

## References

- MySQL transactions:
  https://dev.mysql.com/doc/refman/8.0/en/commit.html
- InnoDB locking reads:
  https://dev.mysql.com/doc/refman/8.0/en/innodb-locking-reads.html
- InnoDB isolation levels:
  https://dev.mysql.com/doc/refman/8.0/en/innodb-transaction-isolation-levels.html
- MySQL Workbench preferences:
  https://dev.mysql.com/doc/workbench/en/wb-preferences-sql-editor.html

## AI Assistance

ChatGPT assisted with SQL development, explanations, troubleshooting
and documentation drafts. The student executed the exercises
locally and checked the observed results.

## Execution staging

Run isolation and locking files block by block in the documented A/B order.
Do not execute an entire session A file at once: it includes its later cleanup.
Use Olaje_Joshua_301908840_P3_RegistrationProcedure.sql for creation and Olaje_Joshua_301908840_P3_TestRegistrationProcedure.sql for tests. The original combined upload is retained separately.

## Final MySQL verification evidence

The new screenshots confirm seven tables, the surname index, 10,006 students, 10,000 benchmark students, ten selected surname matches, grade 78 for registration 1 and the presence of register_student. Offering 1 has students 1, 2 and 3; offering 4 has students 3 and 4. All four enrolments are within capacity, and the duplicate-pair query reports zero rows. These verify current state, not a captured historical lock wait.
