USE campusflow;

-- Show enrolment and remaining places for every course offering.
SELECT
    co.offering_id,
    c.course_code,
    c.course_title,
    t.academic_session,
    t.semester,
    co.capacity,
    COUNT(r.registration_id) AS enrolled_students,
    co.capacity - COUNT(r.registration_id) AS remaining_places
FROM course_offerings AS co
JOIN courses AS c
    ON co.course_id = c.course_id
JOIN academic_terms AS t
    ON co.term_id = t.term_id
LEFT JOIN registrations AS r
    ON co.offering_id = r.offering_id
GROUP BY
    co.offering_id,
    c.course_code,
    c.course_title,
    t.academic_session,
    t.semester,
    co.capacity
ORDER BY co.offering_id;
