USE campusflow;

START TRANSACTION;

-- Three departments.
INSERT INTO departments
    (department_id, department_code, department_name)
VALUES
    (1, 'BIO', 'Biological Sciences'),
    (2, 'CSC', 'Computer Science'),
    (3, 'MAT', 'Mathematics');


-- Six students, with two students in each department.
INSERT INTO students
    (student_id, matric_number, first_name, last_name,
     email, department_id)
VALUES
    (1, 'CF/2026/001', 'Ada', 'Okafor', 'ada@example.com', 1),
    (2, 'CF/2026/002', 'Bayo', 'Adeyemi', 'bayo@example.com', 1),
    (3, 'CF/2026/003', 'Amina', 'Bello', 'amina@example.com', 2),
    (4, 'CF/2026/004', 'Chidi', 'Eze', 'chidi@example.com', 2),
    (5, 'CF/2026/005', 'Efe', 'Ojo', 'efe@example.com', 3),
    (6, 'CF/2026/006', 'Fatima', 'Yusuf', 'fatima@example.com', 3);


-- Three lecturers.
INSERT INTO lecturers
    (lecturer_id, staff_number, first_name, last_name,
     email, department_id)
VALUES
    (1, 'STAFF001', 'Musa', 'Ibrahim', 'musa@example.com', 1),
    (2, 'STAFF002', 'Grace', 'Obi', 'grace@example.com', 2),
    (3, 'STAFF003', 'Tunde', 'Akin', 'tunde@example.com', 3);


-- Four catalogue courses.
INSERT INTO courses
    (course_id, course_code, course_title,
     credit_units, department_id)
VALUES
    (1, 'BIO101', 'Introduction to Biology', 3, 1),
    (2, 'CSC101', 'Introduction to Computing', 3, 2),
    (3, 'MAT101', 'Elementary Mathematics', 3, 3),
    (4, 'CSC201', 'Database Fundamentals', 3, 2);


-- Two fictional academic terms.
INSERT INTO academic_terms
    (term_id, academic_session, semester, start_date, end_date)
VALUES
    (1, '2026/2027', 1, '2026-09-14', '2027-01-22'),
    (2, '2026/2027', 2, '2027-02-08', '2027-06-18');


-- Four offerings, all in the first term.
INSERT INTO course_offerings
    (offering_id, course_id, term_id, lecturer_id, capacity)
VALUES
    (1, 1, 1, 1, 3),
    (2, 2, 1, 2, 3),
    (3, 3, 1, 3, 4),
    (4, 4, 1, 2, 2);


-- Eight registrations.
-- NULL means that a grade has not yet been recorded.
INSERT INTO registrations
    (registration_id, student_id, offering_id,
     registered_at, grade)
VALUES
    (1, 1, 1, '2026-09-14 09:00:00', 78),
    (2, 2, 1, '2026-09-14 09:05:00', 65),
    (3, 3, 2, '2026-09-14 09:10:00', 82),
    (4, 4, 2, '2026-09-14 09:15:00', NULL),
    (5, 1, 3, '2026-09-14 09:20:00', 71),
    (6, 5, 3, '2026-09-14 09:25:00', 69),
    (7, 6, 3, '2026-09-14 09:30:00', NULL),
    (8, 3, 4, '2026-09-14 09:35:00', NULL);

COMMIT;

USE campusflow;

SELECT 'departments' AS table_name, COUNT(*) AS row_count
FROM departments
UNION ALL
SELECT 'students', COUNT(*) FROM students
UNION ALL
SELECT 'lecturers', COUNT(*) FROM lecturers
UNION ALL
SELECT 'courses', COUNT(*) FROM courses
UNION ALL
SELECT 'academic_terms', COUNT(*) FROM academic_terms
UNION ALL
SELECT 'course_offerings', COUNT(*) FROM course_offerings
UNION ALL
SELECT 'registrations', COUNT(*) FROM registrations;


SELECT
    s.matric_number,
    s.first_name,
    c.course_code,
    c.course_title,
    r.grade
FROM registrations AS r
JOIN students AS s
    ON r.student_id = s.student_id
JOIN course_offerings AS co
    ON r.offering_id = co.offering_id
JOIN courses AS c
    ON co.course_id = c.course_id
WHERE s.student_id = 1
ORDER BY c.course_code;