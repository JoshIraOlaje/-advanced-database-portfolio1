-- Corrected staging of the originally supplied session A file.
-- Run BLOCK A1, then session B, then BLOCK A2. Never execute this whole file at once.
-- BLOCK A1: start with registration 1 grade=78.
USE campusflow;
SELECT CONNECTION_ID() AS connection_a_id;
START TRANSACTION;
UPDATE registrations SET grade=80 WHERE registration_id=1;
SELECT registration_id,grade FROM registrations WHERE registration_id=1;
-- PAUSE. A should show 80. Run session B while this transaction is open.

-- BLOCK A2: run ONLY AFTER B has read the grade and committed.
ROLLBACK;
SELECT registration_id,grade FROM registrations WHERE registration_id=1;
-- Expected restored grade: 78.
