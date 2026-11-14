# Portfolio 1: Case Study and Business Rules

## 1. Case Study
CampusFlow is a simulated university course registration system.
All sample records will be synthetic.

The system stores departments, students, lecturers, courses,
academic terms, course offerings and registrations.

It supports course registration, class lists, grade recording
and enrolment reporting.

## 2. Scope and Assumptions
- Each student belongs to one department.
- Each lecturer belongs to one department.
- Each course is owned by one department.
- Students may register for courses outside their department.
- An academic term represents one semester within an academic session.
- A course can have only one offering in a particular academic term.
- Each course offering has one assigned lecturer.
- Team teaching and multiple class sections are outside this version's scope.
- Fees, authentication, prerequisites and timetable clashes are outside scope.
- Registration withdrawal is outside this version's scope.

## 3. Entities
| Entity | What one record represents |
|---|---|
| Department | One academic department |
| Student | One student |
| Lecturer | One lecturer |
| Course | One course in the university catalogue |
| Academic term | One semester in an academic session |
| Course offering | One course taught during a particular term |
| Registration | One student's registration for one course offering |

## 4. Business Rules

### Departments
- Each department has a unique identifier.
- Department codes and department names must be unique.
- A department may initially have no students, lecturers or courses.

### Students
- Each student has a unique identifier and matriculation number.
- Each student must have a first name, last name and unique email address.
- Each student must belong to an existing department.
- A student may have no registrations or many registrations.

### Lecturers
- Each lecturer has a unique identifier and staff number.
- Each lecturer must have a first name, last name and unique email address.
- Each lecturer must belong to an existing department.
- A lecturer may teach no offerings or many offerings.

### Courses
- Each course has a unique identifier and course code.
- Each course must have a title and credit units.
- Credit units must be a whole number between 1 and 6.
- Each course must belong to an existing department.
- A course may have no offerings or many offerings over time.

### Academic Terms
- Each term has a unique identifier.
- The combination of academic session and semester must be unique.
- Semester must be either 1 or 2.
- Each term must have a start date and end date.
- The end date must be later than the start date.

### Course Offerings
- Each offering has a unique identifier.
- Each offering must reference an existing course, term and lecturer.
- The combination of course and academic term must be unique.
- Capacity must be a positive whole number.
- An offering may initially have no registrations.

### Registrations
- Each registration has a unique identifier.
- Each registration must reference an existing student and offering.
- A student cannot register for the same offering more than once.
- Each registration must record its registration date and time.
- A grade may be absent until marking is completed.
- When present, a grade must be a whole number between 0 and 100.
- The number of registrations must not exceed the offering's capacity.

## 5. Record Preservation
Records referenced by other records must not be deleted through
cascading deletion. For example, deleting a course must not
automatically delete its offerings or student registrations.

## 6. Planned Enforcement
- Primary keys will identify individual records.
- Foreign keys will enforce references between tables.
- Unique constraints will prevent duplicate business identifiers
  and duplicate registrations.
- NOT NULL constraints will require essential values.
- CHECK constraints will restrict permitted numeric values and dates.
- A transaction with appropriate locking will enforce offering capacity.
  This will be implemented and tested in Portfolio 3.

## 7. Design Status
These are proposed requirements for the simulated system.
The ER diagram, relational schema and implementation will follow.
