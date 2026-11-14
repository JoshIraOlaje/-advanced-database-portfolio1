SELECT CONNECTION_ID() AS connection_id;

USE campusflow;

-- Use READ COMMITTED for the next transaction.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

SELECT registration_id, grade
FROM registrations
WHERE registration_id = 1;

COMMIT;
