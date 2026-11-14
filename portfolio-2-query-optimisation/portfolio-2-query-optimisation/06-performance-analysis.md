# Surname Search: Indexing and Performance Analysis

## Objective

Evaluate whether an index on students.last_name improves a
surname search in the CampusFlow database.

## Environment and Dataset

- MySQL Community Server 8.0.46.
- InnoDB storage engine.
- Windows 11 and MySQL Workbench.
- 10,006 student records: six initial students and 10,000
  synthetic benchmark students.
- The searched surname, Benchmark0050, matches ten students.

## Query

SELECT
    student_id,
    matric_number,
    first_name,
    last_name,
    department_id
FROM students
WHERE last_name = 'Benchmark0050';

The selected columns and surname condition were unchanged
between the two measurements.

## Index Added

CREATE INDEX idx_students_last_name
    ON students (last_name);

The existing student indexes covered student_id, matric_number,
email and department_id. None indexed last_name.

## Observed Results

| Measure | Before index | After index |
|---|---:|---:|
| Access method | Table scan | Index lookup |
| Actual rows returned by scan or lookup | 10,006 | 10 |
| Final matching rows | 10 | 10 |
| Top-level completion time | 4.79 ms | 0.0777 ms |

The before-index plan scanned all 10,006 student rows and then
filtered them to ten matches.

The after-index plan used idx_students_last_name to retrieve
the ten matching rows.

EXPLAIN ANALYZE timings are in milliseconds. The completion
time is the second number in the top-level actual time range.
Both displayed executions had loops=1.

## Calculation

Observed completion-time reduction:

((4.79 - 0.0777) / 4.79) × 100 = approximately 98.38%.

These figures compare one captured execution before indexing
with one captured execution after indexing. They are not
averages from repeated measurements.

## Interpretation

For the captured surname search, indexing changed retrieval
from a full table scan to an index lookup.

The surname matched only ten of the 10,006 students, so the
index allowed MySQL to retrieve a small subset directly.

The evidence supports using this index for this specific
surname-search workload.

## Limitations and Trade-offs

- Only one captured execution per condition is analysed.
- Cache state and background activity were not controlled.
- EXPLAIN ANALYZE introduces measurement overhead.
- Timings describe instrumented server execution rather than
  the full application or network response time.
- The synthetic surname distribution may differ from real data.
- Results do not establish the same improvement for other
  queries, larger systems or concurrent workloads.
- The index requires storage and maintenance when indexed
  values are inserted, updated or deleted.
- Index size and write-performance overhead were not measured.

A stronger follow-up would compare repeated executions under
both conditions using the same warm-up procedure and report
the median and range.

## Evidence

Repository screenshots document the before-index table scan
and the after-index lookup with their actual execution timings.

## References

MySQL 8.0 Reference Manual — EXPLAIN Statement:
https://dev.mysql.com/doc/refman/8.0/en/explain.html

MySQL 8.0 Reference Manual — EXPLAIN Output Format:
https://dev.mysql.com/doc/refman/8.0/en/explain-output.html
