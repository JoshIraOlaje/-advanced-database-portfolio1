-- READ ONLY. Run on the current completed database; do not rerun seed scripts.
USE campusflow;
SELECT VERSION() AS server_version,@@default_storage_engine AS storage_engine;
SELECT table_name FROM information_schema.tables
WHERE table_schema='campusflow' AND table_type='BASE TABLE' ORDER BY table_name;
SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS benchmark_students FROM students WHERE matric_number LIKE 'CF/BENCH/%';
SELECT COUNT(*) AS surname_matches FROM students WHERE last_name='Benchmark0050';
SHOW INDEX FROM students WHERE Key_name='idx_students_last_name';
SELECT routine_name,routine_type FROM information_schema.routines
WHERE routine_schema='campusflow' AND routine_name='register_student';
SELECT registration_id,grade FROM registrations WHERE registration_id=1;
SELECT co.offering_id,co.capacity,COUNT(r.registration_id) AS enrolled_students,
       co.capacity-COUNT(r.registration_id) AS remaining_places
FROM course_offerings co LEFT JOIN registrations r ON co.offering_id=r.offering_id
GROUP BY co.offering_id,co.capacity ORDER BY co.offering_id;
SELECT student_id,offering_id FROM registrations
WHERE offering_id IN(1,4) ORDER BY offering_id,student_id;
SELECT student_id,offering_id,COUNT(*) AS copies FROM registrations
GROUP BY student_id,offering_id HAVING COUNT(*)>1;
