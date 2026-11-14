# Portfolio 1: Relational Schema

## 1. Notation
- PK: primary key, uniquely identifying each row.
- FK: foreign key, referencing another table.
- UNIQUE: prevents duplicate values or duplicate combinations.
- NOT NULL: requires a value.
- NULL: permits an absent value.

All columns are NOT NULL unless explicitly marked NULL.
All primary keys are positive, automatically generated integers.

Column lengths and numeric ranges below are design choices
for this simulated system.

## 2. Departments

DEPARTMENTS(
    department_id INT PK,
    department_code VARCHAR(10) UNIQUE,
    department_name VARCHAR(100) UNIQUE
)

## 3. Students

STUDENTS(
    student_id INT PK,
    matric_number VARCHAR(25) UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(254) UNIQUE,
    department_id INT FK
)

Foreign key:
department_id references DEPARTMENTS(department_id).

## 4. Lecturers

LECTURERS(
    lecturer_id INT PK,
    staff_number VARCHAR(25) UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(254) UNIQUE,
    department_id INT FK
)

Foreign key:
department_id references DEPARTMENTS(department_id).

## 5. Courses

COURSES(
    course_id INT PK,
    course_code VARCHAR(15) UNIQUE,
    course_title VARCHAR(150),
    credit_units INT,
    department_id INT FK
)

Foreign key:
department_id references DEPARTMENTS(department_id).

Check:
credit_units must be between 1 and 6 inclusive.

## 6. Academic Terms

ACADEMIC_TERMS(
    term_id INT PK,
    academic_session VARCHAR(9),
    semester INT,
    start_date DATE,
    end_date DATE
)

Composite unique constraint:
UNIQUE(academic_session, semester).

Checks:
- semester must be 1 or 2.
- end_date must be later than start_date.

The academic_session value uses a label such as 2026/2027.
The proposed schema does not yet validate this label's format.

## 7. Course Offerings

COURSE_OFFERINGS(
    offering_id INT PK,
    course_id INT FK,
    term_id INT FK,
    lecturer_id INT FK,
    capacity INT
)

Foreign keys:
- course_id references COURSES(course_id).
- term_id references ACADEMIC_TERMS(term_id).
- lecturer_id references LECTURERS(lecturer_id).

Composite unique constraint:
UNIQUE(course_id, term_id).

Check:
capacity must be greater than zero.

## 8. Registrations

REGISTRATIONS(
    registration_id INT PK,
    student_id INT FK,
    offering_id INT FK,
    registered_at DATETIME,
    grade INT NULL
)

Foreign keys:
- student_id references STUDENTS(student_id).
- offering_id references COURSE_OFFERINGS(offering_id).

Composite unique constraint:
UNIQUE(student_id, offering_id).

Default:
registered_at defaults to the current timestamp when omitted.

Check:
grade must be NULL or between 0 and 100 inclusive.

A NULL grade means marking has not yet been completed.
A grade of zero is an actual recorded mark.

## 9. Referential Actions

All foreign keys will use:
- ON DELETE RESTRICT
- ON UPDATE RESTRICT

Referenced records cannot be deleted or have their referenced
key changed while dependent records exist.

Other values, such as a student's name or a course title,
can still be updated.

## 10. Capacity Enforcement

The capacity rule compares the number of registrations for
an offering with that offering's capacity.

A foreign key or a simple row-level CHECK constraint does
not enforce this cross-table counting rule.

Portfolio 3 will implement a registration transaction that:
1. Locks the relevant course offering.
2. Checks the current registration count.
3. Inserts a registration only if a place remains.
4. Commits the successful transaction or rolls it back.

All registration operations must follow the agreed locking
procedure for this capacity control to be reliable.

Any future operation that changes capacity must also preserve
the rule that capacity cannot fall below existing enrolment.

## 11. Implementation Status

This document specifies the proposed schema.
SQL creation scripts and execution evidence will follow.
