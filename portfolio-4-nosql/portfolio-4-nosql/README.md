# Portfolio 4: NoSQL and Advanced Data Models

## 1. Overview

This portfolio implements a document model for the CampusFlow
university course registration case study using MongoDB.

It focuses on retrieving a student's academic record for one term.
It is a limited document-based implementation, not a replacement
for every function in the relational database.

## 2. Environment

- MongoDB Community Server running locally on Windows 11.
- MongoDB Compass with its embedded MongoDB shell.
- Connection: mongodb://127.0.0.1:27017
- Database: campusflow_nosql
- Collection: student_term_records

The exact server version can be checked in the shell using:

```javascript
db.version()
```

## 3. Document Model

Each document represents one student in one academic term.

| Field | Purpose |
|---|---|
| _id | Unique identifier combining matric number, session and semester |
| student_id | Identifier corresponding to the relational example |
| matric_number | University student identifier |
| first_name, last_name | Student name |
| department | Embedded department details |
| academic_session | Session label |
| semester | Semester number |
| courses | Array of course registration and grade objects |

Each course object contains an offering identifier, course code,
course title, credit units, lecturer name and grade.

A null grade represents a result that has not yet been recorded.

## 4. Mapping from the Relational Design

| Relational information | Document representation |
|---|---|
| Student details | Top-level student fields |
| Department details | Embedded department object |
| Academic term | Session and semester fields |
| Registrations | Entries in the courses array |
| Course details | Copied into each course object |
| Course offering | offering_id within each course object |
| Lecturer details | Lecturer name within each course object |

The numeric identifiers are informational references.
MongoDB does not enforce foreign keys to the MySQL tables.

## 5. Why This Model Suits the Selected Task

A student term record is normally read as a group: student details,
term information, registered courses and grades.

Embedding those details allows the record to be retrieved as
one document without joining the original relational tables.

One document per term also limits the scope of the course array,
rather than accumulating the student's entire academic history
in one document. No explicit maximum array length is enforced.

This is an access-pattern-based design choice. No performance
comparison between MySQL and MongoDB was conducted.

## 6. Data and Verified Queries

Three synthetic student term documents were inserted:

- Ada Okafor.
- Bayo Adeyemi.
- Chidi Eze.

The documents are manually prepared snapshots based on the initial
CampusFlow sample data. They do not automatically reflect later
MySQL registration changes.

Verified filters:

| Query | Observed result |
|---|---|
| Empty filter {} | Three documents |
| courses.course_code equals BIO101 | Ada and Bayo |
| BIO101 with grade greater than or equal to 70 using $elemMatch | Ada only |

The $elemMatch condition ensures the course code and grade
conditions apply to the same course object.

A matching filter returns the whole student term document,
not only the matching course.

## 7. Embedded Grade Update

Chidi's CSC101 grade was updated from null to 72 using updateOne
with $set and the positional $ operator.

The matching document was retrieved afterward to verify the change.

This changed MongoDB only. It did not update Chidi's MySQL record.

## 8. Files

| File | Purpose |
|---|---|
| 01-student-term-records.json | Exported starting documents |
| 02-document-queries.json | Named examples of Compass filters |
| 03-update-embedded-grade.js | Shell script for updating and checking Chidi's grade |

Screenshots show the document structure, query results and update
evidence.

## 9. Reproduction Instructions

1. Install MongoDB Community Server and Compass.
2. Connect Compass to the local MongoDB server.
3. Create campusflow_nosql with collection student_term_records.
4. Import 01-student-term-records.json into the empty collection.
5. Confirm that three documents exist.
6. Run each filter from 02-document-queries.json individually
   in the Compass filter box.
7. Open the embedded MongoDB shell.
8. Run 03-update-embedded-grade.js by pasting its contents
   into the shell.
9. Verify that Chidi's CSC101 grade is 72.

The initial export should contain Chidi's grade as null.
If it already contains 72, applying the same update may report
modifiedCount: 0 because the value is unchanged.

Do not repeatedly import the same documents into a populated
collection: their existing _id values will cause duplicate-key errors.

## 10. Trade-offs and Limitations

- Department, course and lecturer details are duplicated across
  student term documents.
- Changes to shared details require a defined update policy.
- For these examples, documents are snapshots; automatic
  synchronisation with MySQL has not been implemented.
- The _id convention identifies each student term record, but
  no additional compound unique index enforces the underlying
  student-session-semester fields independently.
- No custom schema validator has been configured. Required fields,
  grade ranges and array structure are therefore not enforced
  by custom collection validation.
- The model does not enforce course capacity across students.
- It does not demonstrate distributed transactions or replication.
- Only three documents were tested, so no scalability claim is made.

For a production design, frequently changing shared information
could be stored in separate collections and referenced.
The choice would depend on read patterns and consistency needs.

## 11. References

- MongoDB embedded data:
  https://www.mongodb.com/docs/manual/data-modeling/embedding/
- Handling duplicated data:
  https://www.mongodb.com/docs/manual/data-modeling/handle-duplicate-data/
- Positional update operator:
  https://www.mongodb.com/docs/manual/reference/operator/update/positional/
- Compass import and export:
  https://www.mongodb.com/docs/compass/import-export/

## 12. AI Assistance

ChatGPT assisted with model development, query and update examples,
troubleshooting and documentation drafts.

The student inserted the documents, executed the queries and update,
and checked the results locally.
