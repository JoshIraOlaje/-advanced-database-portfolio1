USE campusflow;

START TRANSACTION;

INSERT INTO registrations (student_id, offering_id)
VALUES (1, 1);

ROLLBACK;

START TRANSACTION;

UPDATE registrations
SET grade = 105
WHERE registration_id = 1;

ROLLBACK;

START TRANSACTION;

INSERT INTO students (
    matric_number,
    first_name,
    last_name,
    email,
    department_id
)
VALUES (
    'CF/2026/999',
    'Test',
    'Student',
    'test.student@example.com',
    999
);

ROLLBACK;

START TRANSACTION;

UPDATE students
SET first_name = NULL
WHERE student_id = 1;

ROLLBACK;


SELECT
    (SELECT COUNT(*) FROM students) AS student_count,
    (SELECT COUNT(*) FROM registrations) AS registration_count;

SELECT first_name
FROM students
WHERE student_id = 1;

SELECT grade
FROM registrations
WHERE registration_id = 1;