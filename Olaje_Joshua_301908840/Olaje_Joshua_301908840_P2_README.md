# Portfolio 2: Query Processing and Optimisation

## Overview

This portfolio demonstrates CampusFlow reporting queries,
execution-plan interpretation and a surname-indexing experiment.

## Environment

- MySQL Community Server 8.0.46.
- InnoDB storage engine.
- MySQL Workbench.
- Windows 11.

## Files

| File | Purpose |
|---|---|
| Olaje_Joshua_301908840_P2_EnrolmentReport.sql | Report enrolment and remaining places |
| Olaje_Joshua_301908840_P2_AcademicReport.sql | Retrieve a student's academic records and inspect the execution plan |
| Olaje_Joshua_301908840_P2_GenerateBenchmarkStudents.sql | Generate 10,000 synthetic students |
| Olaje_Joshua_301908840_P2_SurnameBeforeIndex.sql | Retrieve surname matches and capture the baseline plan and timing |
| Olaje_Joshua_301908840_P2_SurnameAfterIndex.sql | Create the surname index and inspect indexed execution |
| Olaje_Joshua_301908840_P2_PerformanceAnalysis.md | Interpret the observed results and limitations |

Screenshots provide supporting evidence of query results,
execution plans and measured timings.

## Prerequisites

Complete the Portfolio 1 table creation and initial sample-data
scripts before running this portfolio.

The initial dataset contains six students and eight registrations.

## Implementation Order

1. Run the enrolment report and student academic report.
2. Inspect existing indexes:

```sql
USE campusflow;
SHOW INDEX FROM students;
SHOW INDEX FROM registrations;
```

3. Run the corrected CTE-based benchmark generation script once.
   Commit only after successful insertion.
4. Verify 10,006 total students, including 10,000 benchmark students.
5. Before creating the surname index, capture the baseline search
   result, EXPLAIN plan and EXPLAIN ANALYZE output.
6. Create idx_students_last_name once and capture the indexed plan
   and EXPLAIN ANALYZE output.
7. Compare the evidence and document limitations.

Do not rerun the benchmark insertion against populated data.
The baseline must be captured before creating the surname index.

## Reporting Results

The initial enrolment report returned:

| Course | Capacity | Enrolled | Remaining |
|---|---:|---:|---:|
| BIO101 | 3 | 2 | 1 |
| CSC101 | 3 | 2 | 1 |
| MAT101 | 4 | 3 | 1 |
| CSC201 | 2 | 1 | 1 |

Ada's academic report returned BIO101 with grade 78 and MAT101
with grade 71.

The academic-report plan selected existing unique and primary-key
indexes. It also showed temporary-table processing and sorting.
No measured performance problem was established for that report.

## Surname Indexing Experiment

The surname Benchmark0050 matched ten students.

| Measure | Before index | After index |
|---|---:|---:|
| Access method | Table scan | Index lookup |
| Actual rows returned by scan or lookup | 10,006 | 10 |
| Final matching rows | 10 | 10 |
| Top-level completion time | 4.79 ms | 0.0777 ms |

The observed completion-time reduction was approximately 98.38%.

These are individual captured executions, not repeated-run averages.
The findings apply to this query and dataset; cache conditions,
measurement overhead and synthetic data limit generalisation.

## Implementation Challenge

An initial generator reused one temporary table under four aliases
and produced MySQL error 1137: Can't reopen table.

The generator was corrected to use a common table expression.
The corrected insertion succeeded and the expected counts were
verified.

## References

- MySQL EXPLAIN:
  https://dev.mysql.com/doc/refman/8.0/en/explain.html
- MySQL EXPLAIN output:
  https://dev.mysql.com/doc/refman/8.0/en/explain-output.html
- MySQL temporary-table limitations:
  https://dev.mysql.com/doc/refman/8.0/en/temporary-table-problems.html

## AI Assistance

ChatGPT assisted with query development, explanations, troubleshooting
and documentation drafts. The student executed the scripts locally,
checked results and supplied screenshots for interpretation.
