USE campusflow;

-- Show Ada's registered courses, lecturers and grading status.
SELECT
    s.matric_number,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_code,
    c.course_title,
    c.credit_units,
    t.academic_session,
    t.semester,
    CONCAT(l.first_name, ' ', l.last_name) AS lecturer_name,
    r.grade,
    CASE
        WHEN r.grade IS NULL THEN 'Awaiting grade'
        ELSE 'Graded'
    END AS grading_status
FROM students AS s
JOIN registrations AS r
    ON s.student_id = r.student_id
JOIN course_offerings AS co
    ON r.offering_id = co.offering_id
JOIN courses AS c
    ON co.course_id = c.course_id
JOIN academic_terms AS t
    ON co.term_id = t.term_id
JOIN lecturers AS l
    ON co.lecturer_id = l.lecturer_id
WHERE s.matric_number = 'CF/2026/001'
ORDER BY
    t.academic_session,
    t.semester,
    c.course_code;
    
    
    
EXPLAIN
SELECT
    s.matric_number,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_code,
    c.course_title,
    c.credit_units,
    t.academic_session,
    t.semester,
    CONCAT(l.first_name, ' ', l.last_name) AS lecturer_name,
    r.grade,
    CASE
        WHEN r.grade IS NULL THEN 'Awaiting grade'
        ELSE 'Graded'
    END AS grading_status
FROM students AS s
JOIN registrations AS r
    ON s.student_id = r.student_id
JOIN course_offerings AS co
    ON r.offering_id = co.offering_id
JOIN courses AS c
    ON co.course_id = c.course_id
JOIN academic_terms AS t
    ON co.term_id = t.term_id
JOIN lecturers AS l
    ON co.lecturer_id = l.lecturer_id
WHERE s.matric_number = 'CF/2026/001'
ORDER BY
    t.academic_session,
    t.semester,
    c.course_code;