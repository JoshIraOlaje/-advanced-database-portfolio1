# Portfolio 1: Relational Schema

## 1. Notation

- PK: primary key, uniquely identifying each row.
- FK: foreign key, referencing another table.
- UNIQUE: prevents duplicate values or duplicate combinations.
- NOT NULL: requires a value.
- NULL: permits an absent value.
- UNSIGNED: does not permit negative integer values.
- AUTO_INCREMENT: generates an identifier when it is omitted during insertion.

All columns are NOT NULL unless explicitly marked NULL.

All primary keys use INT UNSIGNED AUTO_INCREMENT.
Related foreign keys also use INT UNSIGNED.

Identifiers were supplied explicitly when inserting the initial
sample dataset. Future inserts can omit the primary key to let
MySQL generate it.

Column lengths and numeric ranges below are design choices
for this simulated system.

The definitions below describe the relational schema.
They are documentation notation, not executable SQL.

## 2. Departments

```text
DEPARTMENTS(
    department_id INT UNSIGNED AUTO_INCREMENT PK,
    department_code VARCHAR(10) UNIQUE,
    department_name VARCHAR(100) UNIQUE
)
```

## 3. Students

```text
STUDENTS(
    student_id INT UNSIGNED AUTO_INCREMENT PK,
    matric_number VARCHAR(25) UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(254) UNIQUE,
    department_id INT UNSIGNED FK
)
```

Foreign key:
department_id references DEPARTMENTS(department_id).

## 4. Lecturers

```text
LECTURERS(
    lecturer_id INT UNSIGNED AUTO_INCREMENT PK,
    staff_number VARCHAR(25) UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(254) UNIQUE,
    department_id INT UNSIGNED FK
)
```

Foreign key:
department_id references DEPARTMENTS(department_id).

## 5. Courses

```text
COURSES(
    course_id INT UNSIGNED AUTO_INCREMENT PK,
    course_code VARCHAR(15) UNIQUE,
    course_title VARCHAR(150),
    credit_units INT,
    department_id INT UNSIGNED FK
)
```

Foreign key:
department_id references DEPARTMENTS(department_id).

Check:
credit_units must be between 1 and 6 inclusive.

## 6. Academic Terms

```text
ACADEMIC_TERMS(
    term_id INT UNSIGNED AUTO_INCREMENT PK,
    academic_session VARCHAR(9),
    semester INT,
    start_date DATE,
    end_date DATE
)
```

Composite unique constraint:
UNIQUE(academic_session, semester).

Checks:

- semester must be 1 or 2.
- end_date must be later than start_date.

The academic_session value uses a label such as 2026/2027.
The implemented schema does not validate this label's format.

## 7. Course Offerings

```text
COURSE_OFFERINGS(
    offering_id INT UNSIGNED AUTO_INCREMENT PK,
    course_id INT UNSIGNED FK,
    term_id INT UNSIGNED FK,
    lecturer_id INT UNSIGNED FK,
    capacity INT
)
```

Foreign keys:

- course_id references COURSES(course_id).
- term_id references ACADEMIC_TERMS(term_id).
- lecturer_id references LECTURERS(lecturer_id).

Composite unique constraint:
UNIQUE(course_id, term_id).

Check:
capacity must be greater than zero.

## 8. Registrations

```text
REGISTRATIONS(
    registration_id INT UNSIGNED AUTO_INCREMENT PK,
    student_id INT UNSIGNED FK,
    offering_id INT UNSIGNED FK,
    registered_at DATETIME,
    grade INT NULL
)
```

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

All foreign keys use:

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

All seven tables have been created in MySQL Community Server
8.0.46 using InnoDB.

Synthetic sample data has been inserted and checked:

| Table | Verified row count |
|---|---:|
| departments | 3 |
| students | 6 |
| lecturers | 3 |
| courses | 4 |
| academic_terms | 2 |
| course_offerings | 4 |
| registrations | 8 |

Ada's registrations were checked and returned:

- BIO101: grade 78.
- MAT101: grade 71.

Manual constraint tests confirmed rejection of:

- A duplicate student-offering registration.
- A grade of 105.
- A student referencing nonexistent department 999.
- A NULL student first name.

Each constraint test was followed by ROLLBACK.
Subsequent verification confirmed that the checked original
records and row counts remained unchanged.

Offering capacity enforcement remains scheduled for Portfolio 3.
