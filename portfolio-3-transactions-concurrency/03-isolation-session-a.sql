USE campusflow;

START TRANSACTION;

UPDATE registrations
SET grade = 80
WHERE registration_id = 1;

COMMIT;

-- Expected grade: 80.
SELECT registration_id, grade
FROM registrations
WHERE registration_id = 1;

ROLLBACK;

-- Expected grade: still 80.
SELECT registration_id, grade
FROM registrations
WHERE registration_id = 1;


START TRANSACTION;

UPDATE registrations
SET grade = 78
WHERE registration_id = 1;

COMMIT;

-- Expected grade: 78.
SELECT registration_id, grade
FROM registrations
WHERE registration_id = 1;


SELECT CONNECTION_ID() AS connection_id;



USE campusflow;

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
