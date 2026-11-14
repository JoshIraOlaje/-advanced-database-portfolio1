-- Recovered from the last-place registration exercise; not newly executed here.
-- Use separate A and B connections. Run labelled blocks in order A0,A1,B1,A2,B2.
-- Do not rerun A2 if student 3 is already registered for offering 1.
-- BLOCK A0: preflight. Expect capacity=3, enrolled=2 before the demonstration.
USE campusflow;
SELECT co.offering_id,co.capacity,COUNT(r.registration_id) AS enrolled_students
FROM course_offerings co LEFT JOIN registrations r ON co.offering_id=r.offering_id
WHERE co.offering_id=1 GROUP BY co.offering_id,co.capacity;
SELECT student_id,offering_id FROM registrations WHERE offering_id=1;

-- BLOCK A1: execute only after preflight confirms the starting state.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT offering_id,capacity FROM course_offerings WHERE offering_id=1 FOR UPDATE;
-- PAUSE: start B1. B should wait. Then promptly execute A2, before timeout.

-- BLOCK A2: keep the offering lock while checking and registering.
SELECT COUNT(*) AS enrolled_students FROM registrations WHERE offering_id=1;
-- Execute INSERT below ONLY if the count is still 2 and student 3 is not registered.
INSERT INTO registrations(student_id,offering_id) VALUES(3,1);
COMMIT;
-- If a statement errors, ROLLBACK and inspect current data instead of blindly retrying.
