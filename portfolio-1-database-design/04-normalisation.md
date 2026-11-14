# Portfolio 1: Normalisation

## 1. Purpose

CampusFlow separates information into related tables to reduce
unnecessary duplication and prevent insertion, update and deletion
anomalies.

The design targets Third Normal Form (3NF), based on the business
rules and functional dependencies documented below.

A functional dependency X -> Y means that one value of X determines
one value of Y.

## 2. Problems with a Single Combined Table

Suppose one table stores student details, department details,
course details, term details, lecturer details and grades for
every registration.

This would repeat student information across registrations
and course information across students.

Possible anomalies include:

- Update anomaly: changing a course title in only some registration
  rows would leave conflicting titles.
- Insertion anomaly: a new course could not be recorded cleanly
  if the table required a student registration in every row.
- Deletion anomaly: deleting the only registration for a course
  could also remove the only stored information about that course.

Separate tables allow courses and students to exist independently
of registrations.

## 3. First Normal Form (1NF)

Each table has a primary key, and each column holds one value
of its defined type for each row.

There are no repeating columns such as course_1, course_2
and course_3, and no comma-separated lists of course identifiers.

Each student-offering registration occupies its own row in
REGISTRATIONS.

A student taking three offerings therefore has three registration
rows, rather than three course columns in STUDENTS.

## 4. Second Normal Form (2NF)

A table is in 2NF when it is in 1NF and every non-prime attribute
depends on every candidate key in full, rather than only part
of a composite candidate key.

A candidate key is a minimal set of columns that uniquely
identifies a row. A prime attribute belongs to at least one
candidate key.

CampusFlow includes these composite candidate keys:

- ACADEMIC_TERMS: (academic_session, semester)
- COURSE_OFFERINGS: (course_id, term_id)
- REGISTRATIONS: (student_id, offering_id)

For example, in REGISTRATIONS:

(student_id, offering_id) -> registered_at, grade

The registration date and grade describe the student's registration
for that particular offering. Neither student_id nor offering_id
alone determines them.

Student names are stored in STUDENTS because they depend on
the student, not the complete student-offering combination.

The presence of a single-column surrogate primary key does not
remove the need to check other candidate keys for partial
dependencies.

## 5. Third Normal Form (3NF)

A table is in 3NF when, for every non-trivial functional dependency
X -> A, X is a superkey or A is a prime attribute.

A superkey is a set of columns that uniquely identifies a row;
it need not be minimal.

In this design, descriptive information is stored with the entity
that determines it.

For example:

student_id -> department_id
department_id -> department_name

Storing department_name in STUDENTS would introduce a transitive
dependency on student_id through department_id.

Instead, STUDENTS stores department_id, while DEPARTMENTS stores
department_name.

Similarly:

- Course titles and credit units are stored in COURSES.
- Lecturer names and email addresses are stored in LECTURERS.
- Term dates are stored in ACADEMIC_TERMS.
- Offering capacity and the assigned lecturer are stored in
  COURSE_OFFERINGS.
- Registration dates and grades are stored in REGISTRATIONS.

## 6. Candidate Keys and Main Functional Dependencies

The following dependencies reflect the proposed business rules.
Each listed candidate key determines all other columns in its table.

| Table | Candidate keys | Main dependency using the primary key |
|---|---|---|
| DEPARTMENTS | department_id; department_code; department_name | department_id -> department_code, department_name |
| STUDENTS | student_id; matric_number; email | student_id -> matric_number, first_name, last_name, email, department_id |
| LECTURERS | lecturer_id; staff_number; email | lecturer_id -> staff_number, first_name, last_name, email, department_id |
| COURSES | course_id; course_code | course_id -> course_code, course_title, credit_units, department_id |
| ACADEMIC_TERMS | term_id; (academic_session, semester) | term_id -> academic_session, semester, start_date, end_date |
| COURSE_OFFERINGS | offering_id; (course_id, term_id) | offering_id -> course_id, term_id, lecturer_id, capacity |
| REGISTRATIONS | registration_id; (student_id, offering_id) | registration_id -> student_id, offering_id, registered_at, grade |

All candidate-key columns will be required and unique, either
individually or as a combination.

These dependencies assume that each student has one home department,
each course has one owning department, and each offering has one
lecturer.

Different university requirements could require a revised design.

## 7. Conclusion

Under the stated business rules, the proposed tables satisfy 3NF:

- Values are stored without repeating groups.
- Non-prime attributes have no partial dependencies on candidate keys.
- No non-key descriptive attribute determines another non-key
  descriptive attribute within the same table.

Normalisation does not enforce every business rule. Preventing
over-enrolment still requires the transaction and concurrency
control planned for Portfolio 3.

## 8. Reference

Watt, A. and Eng, N. Database Design – 2nd Edition.
Chapters 11 and 12: Functional Dependencies and Normalization.

https://opentextbc.ca/dbdesign/
