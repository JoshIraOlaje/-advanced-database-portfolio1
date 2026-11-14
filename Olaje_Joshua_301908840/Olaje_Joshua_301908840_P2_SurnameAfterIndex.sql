USE campusflow;

CREATE INDEX idx_students_last_name
    ON students (last_name);

-- Confirm that the new index exists.
SHOW INDEX FROM students
WHERE Key_name = 'idx_students_last_name';


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