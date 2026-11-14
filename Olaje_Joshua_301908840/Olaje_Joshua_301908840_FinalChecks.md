# Final checks and recovery record

## Scope

This package was recovered from the uploaded GitHub snapshot and the visible project commands and screenshots. The original ZIP, remote repository and user databases were not modified. Recovered code is not claimed as a fresh successful execution.

## Recovery completed

- Restored the corrected CTE benchmark generator from the commands previously used and confirmed by the student.
- Restored separate, staged locking session A and B scripts.
- Restored the MongoDB embedded-grade update script.
- Added the missing Portfolio 1 README and database bootstrap commands.
- Extracted read-only sample verification from the supplied sample-data script.
- Separated procedure creation and test calls; retained the original combined SQL as an explicitly labelled original.
- Corrected isolation A to show the A1 -> B -> A2 execution order.
- Recovered the original before-index screenshot and the two index inventories from separate conversation attachments.
- Updated documentation references to the renamed files and disclosed evidence limitations.

## Checks completed in this environment

| Check | Result |
|---|---|
| Enclosing ZIP folder | Olaje_Joshua_301908840 |
| All filenames carry required prefix and no spaces | Passed |
| No nested portfolio folders | Passed |
| Local Markdown link destinations exist | Passed |
| JSON parsing | Passed |
| Initial MongoDB snapshot | Three distinct IDs; Ada 78/71, Bayo 65, Chidi null |
| Both JavaScript files | Node syntax checks passed; MongoDB commands not executed here |
| Screenshot files | Image decoding passed |
| Files labelled .sql | Text rather than disguised PNG data |
| Final PDF | Three pages; previously rendered and visually checked |
| Generator mathematical consistency | 10,000 distinct generated matric numbers and emails; departments 1–3; 10 selected surname matches |
| Duplicate consolidation | Only the two previously verified byte-identical root duplicates were consolidated |

No MySQL or MongoDB runtime is available in this environment. SQL execution, procedure behaviour and current database state require the student's local checks below. Static checks are not database execution tests.

## Final checks to run on Windows

### MySQL Workbench

Run `Olaje_Joshua_301908840_P3_FinalVerification.sql` as read-only queries. Expected checks:

- Seven CampusFlow base tables.
- 10,006 students, 10,000 benchmark students and 10 surname matches.
- idx_students_last_name exists.
- register_student exists.
- Registration 1 grade is 78 after cleanup.
- No offering exceeds capacity.
- Offering 1 has students 1, 2 and 3 after the locking exercise.
- Offering 4 has students 3 and 4 if the successful procedure call was completed.
- The duplicate-pair query returns no rows.

Do not rerun the sample data or generator on an already populated database. If offering 4 still has only student 3, inspect its capacity; only then use the existing procedure test instructions to complete the previously planned registration.

Save actual results as fresh verification evidence using a name such as `Olaje_Joshua_301908840_P3_FinalVerificationEvidence.png`.

### MongoDB Compass shell

Run `Olaje_Joshua_301908840_P4_FinalVerification.js` in the embedded shell. Expected counts are 3 total documents, 2 BIO101 documents and 1 BIO101 document with grade at least 70. Chidi's CSC101 grade should be 72 after the update exercise. Record the actual server version.

If Chidi is still null, the previously demonstrated update can be run from `Olaje_Joshua_301908840_P4_UpdateEmbeddedGrade.js`. Repeating it when grade is already 72 may report modifiedCount 0; that is not evidence of failure.

Save the actual output as `Olaje_Joshua_301908840_P4_FinalVerificationEvidence.png`.

### Evidence limitations

The existing package does not contain an original screenshot of every expected constraint error, the successful lock wait, the successful procedure registration or the MongoDB grade update. Some outcomes were confirmed by the student in conversation. Fresh verification supports current state but cannot retroactively prove how a prior concurrent execution occurred. No timings or screenshots were fabricated.

## GitHub and submission closeout

1. Download and extract this package; review the recovered scripts and comments.
2. Update the EXISTING repository with corrected files while retaining its commit history. Do not create a replacement repository or rewrite commit dates.
3. Make the final repository organisation and filenames agree with this package. A prefixed README filename is not automatically displayed as GitHub's conventional README.md; use the file link to open it.
4. Update any remote links if the repository is renamed. The PDF currently links to https://github.com/JoshIraOlaje/-advanced-database-portfolio1 and that remote repository has not been renamed here.
5. Confirm assessor access using their correct GitHub username or account and ensure any invitation is accepted.
6. Review the three-page summary, including reflection and AI declaration.
7. Upload the required LMS report and any folder/archive requested by the submission form.
8. Retain the LMS confirmation or receipt. This package does not claim an LMS submission has occurred.

## Status

File recovery and local packaging checks are complete. User-side read-only verification, GitHub synchronisation, assessor access and LMS submission remain outstanding.

## Updated results from student screenshots

Final MySQL read-only checks are now verified: seven base tables; 10,006 students; 10,000 benchmark students; ten surname matches; surname index present; procedure present; restored grade 78; enrolments 3/3, 2/3, 3/4 and 2/2 for offerings 1–4; expected students in offerings 1 and 4; zero duplicate pairs in Action Output.

The remaining database-evidence action is the Compass final verification screenshot. GitHub synchronisation, assessor access and LMS submission remain outstanding.
