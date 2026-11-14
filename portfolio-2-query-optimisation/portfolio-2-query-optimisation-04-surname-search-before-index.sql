USE campusflow;

-- Retrieve students with the selected surname.
SELECT
    student_id,
    matric_number,
    first_name,
    last_name,
    department_id
FROM students
WHERE last_name = 'Benchmark0050';


EXPLAIN
SELECT
    student_id,
    matric_number,
    first_name,
    last_name,
    department_id
FROM students
WHERE last_name = 'Benchmark0050';


EXPLAIN ANALYZE
SELECT
    student_id,
    matric_number,
    first_name,
    last_name,
    department_id
FROM students
WHERE last_name = 'Benchmark0050';