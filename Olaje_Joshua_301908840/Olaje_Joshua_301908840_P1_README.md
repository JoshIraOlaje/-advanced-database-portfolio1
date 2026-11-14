# Portfolio 1 Database Design and Modelling

This guide was assembled during final packaging from the existing design and SQL files.

## Files and run order

1. `Olaje_Joshua_301908840_P1_CreateDatabase.sql`: create/select campusflow without deleting data.
2. `Olaje_Joshua_301908840_P1_CreateTables.sql`: create the seven tables once on an empty schema.
3. `Olaje_Joshua_301908840_P1_SampleDataAndVerification.sql`: insert initial records once and inspect the included verification results. Check INSERT results before separately running COMMIT; use ROLLBACK on error.
4. `Olaje_Joshua_301908840_P1_VerifySampleData.sql`: independently rerun read-only initial checks.
5. `Olaje_Joshua_301908840_P1_ConstraintTests.sql`: run each expected-error test separately and always run its ROLLBACK afterward.

Expected INITIAL counts: departments 3, students 6, lecturers 3, courses 4, terms 2, offerings 4, registrations 8. Later portfolios change student and registration counts.

## Design documents

- [Business rules](Olaje_Joshua_301908840_P1_CaseStudyBusinessRules.md)
- [ER diagram](Olaje_Joshua_301908840_P1_ERDiagram.md)
- [Relational schema](Olaje_Joshua_301908840_P1_RelationalSchema.md)
- [Normalisation](Olaje_Joshua_301908840_P1_Normalisation.md)

The schema uses primary keys, unsigned matching foreign keys, unique constraints, required values and checks. Capacity across registration rows is handled by Portfolio 3's procedure rather than a simple table CHECK.

## Evidence

The MySQL environment screenshot and final constraint-verification screenshot are present. The student confirmed four expected constraint rejections; individual screenshots of all four errors were not supplied in the ZIP.

## AI assistance

ChatGPT helped draft and recover documentation and scripts. Existing exercise outputs and student confirmations are distinguished from recovered code. No fresh database execution is claimed for this packaging step.
