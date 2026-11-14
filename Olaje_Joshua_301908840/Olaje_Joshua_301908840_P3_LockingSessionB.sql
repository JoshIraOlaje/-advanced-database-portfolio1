-- Recovered from the last-place exercise. Execute B1 after A1; then A2; then B2.
-- BLOCK B1: requests the offering lock and waits for A to commit.
USE campusflow;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT offering_id,capacity FROM course_offerings WHERE offering_id=1 FOR UPDATE;

-- BLOCK B2: run only after B1 completes following A's commit.
SELECT COUNT(*) AS enrolled_students FROM registrations WHERE offering_id=1;
-- Expected 3: no place remains. Do not insert another registration.
ROLLBACK;
-- If a timeout or connection loss occurs, reconnect if needed, roll back open
-- transactions and inspect registrations before attempting another insert.
