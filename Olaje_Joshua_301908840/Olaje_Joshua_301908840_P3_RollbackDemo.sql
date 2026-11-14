USE campusflow;

SELECT registration_id, student_id, offering_id, grade
FROM registrations
WHERE registration_id = 1;

START TRANSACTION;

UPDATE registrations
SET grade = 80
WHERE registration_id = 1;

SELECT registration_id, grade
FROM registrations
WHERE registration_id = 1;

ROLLBACK;

SELECT registration_id, grade
FROM registrations
WHERE registration_id = 1;
