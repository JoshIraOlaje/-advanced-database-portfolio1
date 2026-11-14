# Portfolio 1: Entity–Relationship Diagram

This diagram describes the proposed CampusFlow relational database.

```mermaid
erDiagram
    DEPARTMENTS ||--o{ STUDENTS : has
    DEPARTMENTS ||--o{ LECTURERS : has
    DEPARTMENTS ||--o{ COURSES : owns
    COURSES ||--o{ COURSE_OFFERINGS : has
    ACADEMIC_TERMS ||--o{ COURSE_OFFERINGS : contains
    LECTURERS ||--o{ COURSE_OFFERINGS : teaches
    STUDENTS ||--o{ REGISTRATIONS : makes
    COURSE_OFFERINGS ||--o{ REGISTRATIONS : receives

    DEPARTMENTS {
        int department_id PK
        varchar department_code UK
        varchar department_name UK
    }

    STUDENTS {
        int student_id PK
        varchar matric_number UK
        varchar first_name
        varchar last_name
        varchar email UK
        int department_id FK
    }

    LECTURERS {
        int lecturer_id PK
        varchar staff_number UK
        varchar first_name
        varchar last_name
        varchar email UK
        int department_id FK
    }

    COURSES {
        int course_id PK
        varchar course_code UK
        varchar course_title
        int credit_units
        int department_id FK
    }

    ACADEMIC_TERMS {
        int term_id PK
        varchar academic_session
        int semester
        date start_date
        date end_date
    }

    COURSE_OFFERINGS {
        int offering_id PK
        int course_id FK
        int term_id FK
        int lecturer_id FK
        int capacity
    }

    REGISTRATIONS {
        int registration_id PK
        int student_id FK
        int offering_id FK
        datetime registered_at
        int grade
    }
```

## Composite Unique Constraints

The following combinations must be unique:

| Table | Unique combination | Purpose |
|---|---|---|
| academic_terms | academic_session, semester | Prevent duplicate terms |
| course_offerings | course_id, term_id | Prevent offering the same course twice in one term |
| registrations | student_id, offering_id | Prevent duplicate registration |

The columns within each combination are not individually unique.

## Required and Optional Values

- Every column is required except registrations.grade.
- A missing grade means marking has not yet been completed.
- Each foreign key references exactly one existing parent record.
- A parent record can exist without any related child records.

## Relationship Explanation

Departments have students, lecturers and courses.

Each course offering connects one course, one academic term
and one lecturer.

Registrations connect students to course offerings.
A student can register for many offerings, and an offering
can have many students.

## Rules Beyond the Diagram

The SQL schema will define column lengths, required values,
unique constraints, valid ranges and deletion restrictions.

Offering capacity will be enforced through a transaction
and locking method demonstrated in Portfolio 3.
