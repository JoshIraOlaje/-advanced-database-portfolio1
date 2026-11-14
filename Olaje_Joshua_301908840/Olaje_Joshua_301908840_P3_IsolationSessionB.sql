-- Run this block AFTER session A block A1 and BEFORE A2.
USE campusflow;
SELECT CONNECTION_ID() AS connection_b_id;
-- Check that this differs from A's ID.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT registration_id,grade FROM registrations WHERE registration_id=1;
-- Expected grade 78, even though A sees its uncommitted 80.
COMMIT;
