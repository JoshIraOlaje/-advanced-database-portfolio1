USE campusflow;

-- 1. Departments: parent table for students, lecturers and courses.
CREATE TABLE departments (
    department_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    department_code VARCHAR(10) NOT NULL,
    department_name VARCHAR(100) NOT NULL,

    CONSTRAINT uq_department_code UNIQUE (department_code),
    CONSTRAINT uq_department_name UNIQUE (department_name)
) ENGINE = InnoDB;


-- 2. Students: each student belongs to one department.
CREATE TABLE students (
    student_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    matric_number VARCHAR(25) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(254) NOT NULL,
    department_id INT UNSIGNED NOT NULL,

    CONSTRAINT uq_student_matric UNIQUE (matric_number),
    CONSTRAINT uq_student_email UNIQUE (email),

    CONSTRAINT fk_student_department
        FOREIGN KEY (department_id)
        REFERENCES departments (department_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
) ENGINE = InnoDB;


-- 3. Lecturers: each lecturer belongs to one department.
CREATE TABLE lecturers (
    lecturer_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    staff_number VARCHAR(25) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(254) NOT NULL,
    department_id INT UNSIGNED NOT NULL,

    CONSTRAINT uq_lecturer_staff UNIQUE (staff_number),
    CONSTRAINT uq_lecturer_email UNIQUE (email),

    CONSTRAINT fk_lecturer_department
        FOREIGN KEY (department_id)
        REFERENCES departments (department_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
) ENGINE = InnoDB;


-- 4. Courses: catalogue entries, independent of a particular term.
CREATE TABLE courses (
    course_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(15) NOT NULL,
    course_title VARCHAR(150) NOT NULL,
    credit_units INT NOT NULL,
    department_id INT UNSIGNED NOT NULL,

    CONSTRAINT uq_course_code UNIQUE (course_code),
    CONSTRAINT chk_course_credits
        CHECK (credit_units BETWEEN 1 AND 6),

    CONSTRAINT fk_course_department
        FOREIGN KEY (department_id)
        REFERENCES departments (department_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
) ENGINE = InnoDB;


-- 5. Academic terms: one semester within an academic session.
CREATE TABLE academic_terms (
    term_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    academic_session VARCHAR(9) NOT NULL,
    semester INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,

    CONSTRAINT uq_term_session_semester
        UNIQUE (academic_session, semester),

    CONSTRAINT chk_term_semester
        CHECK (semester IN (1, 2)),

    CONSTRAINT chk_term_dates
        CHECK (end_date > start_date)
) ENGINE = InnoDB;


-- 6. Offerings: connect a course, term and assigned lecturer.
CREATE TABLE course_offerings (
    offering_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    course_id INT UNSIGNED NOT NULL,
    term_id INT UNSIGNED NOT NULL,
    lecturer_id INT UNSIGNED NOT NULL,
    capacity INT NOT NULL,

    CONSTRAINT uq_offering_course_term
        UNIQUE (course_id, term_id),

    CONSTRAINT chk_offering_capacity
        CHECK (capacity > 0),

    CONSTRAINT fk_offering_course
        FOREIGN KEY (course_id)
        REFERENCES courses (course_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,

    CONSTRAINT fk_offering_term
        FOREIGN KEY (term_id)
        REFERENCES academic_terms (term_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,

    CONSTRAINT fk_offering_lecturer
        FOREIGN KEY (lecturer_id)
        REFERENCES lecturers (lecturer_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
) ENGINE = InnoDB;


-- 7. Registrations: connect students to offerings.
CREATE TABLE registrations (
    registration_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    student_id INT UNSIGNED NOT NULL,
    offering_id INT UNSIGNED NOT NULL,
    registered_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    grade INT NULL,

    CONSTRAINT uq_registration_student_offering
        UNIQUE (student_id, offering_id),

    CONSTRAINT chk_registration_grade
        CHECK (grade IS NULL OR grade BETWEEN 0 AND 100),

    CONSTRAINT fk_registration_student
        FOREIGN KEY (student_id)
        REFERENCES students (student_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,

    CONSTRAINT fk_registration_offering
        FOREIGN KEY (offering_id)
        REFERENCES course_offerings (offering_id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
) ENGINE = InnoDB;


-- Verify that all seven tables exist.
SHOW TABLES;