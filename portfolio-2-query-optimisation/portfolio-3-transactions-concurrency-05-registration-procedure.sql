USE campusflow;

DELIMITER //

CREATE PROCEDURE register_student (
    IN p_student_id INT UNSIGNED,
    IN p_offering_id INT UNSIGNED
)
BEGIN
    DECLARE v_capacity INT DEFAULT NULL;
    DECLARE v_enrolled INT DEFAULT 0;

    -- Cancel the transaction and report any error to the caller.
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    START TRANSACTION;

    -- Lock the offering before checking registrations.
    BEGIN
        DECLARE CONTINUE HANDLER FOR NOT FOUND
            SET v_capacity = NULL;

        SELECT capacity INTO v_capacity
        FROM course_offerings
        WHERE offering_id = p_offering_id
        FOR UPDATE;
    END;

    IF v_capacity IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Course offering does not exist';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM registrations
        WHERE student_id = p_student_id
          AND offering_id = p_offering_id
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Student is already registered';
    END IF;

    SELECT COUNT(*) INTO v_enrolled
    FROM registrations
    WHERE offering_id = p_offering_id;

    IF v_enrolled >= v_capacity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Course offering is full';
    END IF;

    INSERT INTO registrations (student_id, offering_id)
    VALUES (p_student_id, p_offering_id);

    COMMIT;

    SELECT
        'Registration successful' AS outcome,
        p_student_id AS student_id,
        p_offering_id AS offering_id;
END //

DELIMITER ;


CALL register_student(4, 1);


SELECT
    co.offering_id,
    co.capacity,
    COUNT(r.registration_id) AS enrolled_students
FROM course_offerings AS co
LEFT JOIN registrations AS r
    ON co.offering_id = r.offering_id
WHERE co.offering_id = 4
GROUP BY co.offering_id, co.capacity;

CALL register_student(4, 4);

SELECT student_id, offering_id
FROM registrations
WHERE offering_id = 4
ORDER BY student_id;