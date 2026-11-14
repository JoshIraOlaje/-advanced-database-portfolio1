-- Recovered from the corrected CTE generator used and confirmed in the project.
-- Run once only after the initial six students exist; do not rerun on current populated data.
USE campusflow;
START TRANSACTION;
INSERT INTO students (matric_number, first_name, last_name, email, department_id)
WITH digits AS (
    SELECT 0 AS digit
    UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
    UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
    UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
), numbers AS (
    SELECT a.digit + 10*b.digit + 100*c.digit + 1000*d.digit AS n
    FROM digits AS a
    CROSS JOIN digits AS b
    CROSS JOIN digits AS c
    CROSS JOIN digits AS d
)
SELECT CONCAT('CF/BENCH/', LPAD(n,5,'0')),
       CONCAT('TestStudent',n),
       CONCAT('Benchmark',LPAD(MOD(n,1000),4,'0')),
       CONCAT('benchmark',n,'@example.com'),
       1+MOD(n,3)
FROM numbers;
-- STOP HERE. Check that INSERT affected 10,000 rows before running COMMIT separately.
-- If INSERT errors, run ROLLBACK instead and investigate.
COMMIT;
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS benchmark_students FROM students WHERE matric_number LIKE 'CF/BENCH/%';
SELECT COUNT(*) AS matching_surname FROM students WHERE last_name='Benchmark0050';
-- Expected after this stage: 10006, 10000, 10.
