-- Extracted and staged from supplied test commands. Run tests separately.
-- Full-offering rejection requires offering 1 to already have 3 registrations.
USE campusflow;
SELECT co.offering_id,co.capacity,COUNT(r.registration_id) AS enrolled_students
FROM course_offerings co LEFT JOIN registrations r ON co.offering_id=r.offering_id
WHERE co.offering_id IN (1,4) GROUP BY co.offering_id,co.capacity;

-- TEST 1: expected error 1644, Course offering is full, if offering 1 is full.
CALL register_student(4,1);

-- TEST 2: execute separately, only if offering 4 has one registration and
-- student 4 is not already registered. Successful execution commits a new row.
CALL register_student(4,4);

-- Verify rather than repeating a successful call.
SELECT student_id,offering_id FROM registrations WHERE offering_id=4 ORDER BY student_id;
-- Expected after success: students 3 and 4.
