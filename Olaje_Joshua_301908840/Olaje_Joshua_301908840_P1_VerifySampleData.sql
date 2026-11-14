-- Extracted from the supplied sample-data SQL. Expected initial counts apply before later portfolios.


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
