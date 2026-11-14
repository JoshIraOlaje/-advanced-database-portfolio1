-- Recovered from the database-creation commands used in the project.
-- Run before CreateTables on a fresh environment. Does not erase data.
CREATE DATABASE IF NOT EXISTS campusflow
    CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE campusflow;
SELECT DATABASE() AS current_database;
SHOW TABLES;
