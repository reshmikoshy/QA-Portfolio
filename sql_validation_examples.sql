- sql_validation_examples.sql
-- SQL Validation Examples for QA Portfolio
-- Works in MySQL (minor adjustments may be needed for other databases)

-- ----------------------------
-- SCHEMA: users, students, courses, enrollments
-- ----------------------------

CREATE TABLE IF NOT EXISTS users (
user_id INTEGER PRIMARY KEY AUTOINCREMENT,
username TEXT UNIQUE NOT NULL,
email TEXT UNIQUE NOT NULL,
password_hash TEXT NOT NULL, -- store hashed passwords in real apps
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS students (
student_id INTEGER PRIMARY KEY AUTOINCREMENT,
user_id INTEGER NOT NULL,
full_name TEXT NOT NULL,
dob DATE,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS courses (
course_id INTEGER PRIMARY KEY AUTOINCREMENT,
course_code TEXT UNIQUE NOT NULL,
course_name TEXT NOT NULL,
credits INTEGER,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS enrollments (
enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
student_id INTEGER NOT NULL,
course_id INTEGER NOT NULL,
enrolled_on DATETIME DEFAULT CURRENT_TIMESTAMP,
status TEXT DEFAULT 'active',
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- ----------------------------
-- SAMPLE DATA
-- ----------------------------

-- Users (password_hash values are placeholders)
INSERT INTO users (username, email, password_hash) VALUES ('john.doe','john@example.com','hash_john');
INSERT INTO users (username, email, password_hash) VALUES ('maria.k','maria@example.com','hash_maria');
INSERT INTO users (username, email, password_hash) VALUES ('sam.s','sam@example.com','hash_sam');

-- Students linked to users
INSERT INTO students (user_id, full_name, dob) VALUES (1, 'John Doe', '1998-02-10');
INSERT INTO students (user_id, full_name, dob) VALUES (2, 'Maria Kumar', '2000-06-21');

-- Courses
INSERT INTO courses (course_code, course_name, credits) VALUES ('LOG101','Intro to Logistics',3);
INSERT INTO courses (course_code, course_name, credits) VALUES ('SCM201','Supply Chain Management',4);
INSERT INTO courses (course_code, course_name, credits) VALUES ('OPS350','Operations Analytics',3);

-- Enrollments
INSERT INTO enrollments (student_id, course_id) VALUES (1, 1); -- John -> LOG101
INSERT INTO enrollments (student_id, course_id) VALUES (1, 2); -- John -> SCM201
INSERT INTO enrollments (student_id, course_id) VALUES (2, 1); -- Maria -> LOG101

-- ----------------------------
-- VALIDATION QUERIES
-- ----------------------------

-- 1) LOGIN VALIDATION
-- Check if a user exists by username (or email). Use parameterized input in your app.
-- Replace :username with actual param in your client code (avoid string concatenation).
SELECT user_id, username, email, password_hash, created_at
FROM users
WHERE username = :username; -- example param :username

-- If you want to validate using email:
SELECT user_id, username, email, password_hash
FROM users
WHERE email = :email;

-- 1b) Check user exists AND password matches (example; compare hashed values in app)
-- WARNING: Do not check plain passwords here; compare hash in application layer.
SELECT user_id, username, email
FROM users
WHERE username = :username AND password_hash = :password_hash;

-- 2) LOGIN - EXISTS boolean-style
-- Return whether user exists (count > 0)
SELECT COUNT(1) AS user_count
FROM users
WHERE username = :username;

-- 3) JOINS: Student -> Enrollment -> Course
-- Get student's courses (join students -> enrollments -> courses)
SELECT s.student_id, s.full_name, c.course_code, c.course_name, e.enrolled_on
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.full_name LIKE 'John%';

-- 3b) Get course roster
SELECT c.course_id, c.course_code, c.course_name, s.student_id, s.full_name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
LEFT JOIN students s ON e.student_id = s.student_id
ORDER BY c.course_code, s.full_name;

-- 4) COUNT QUERIES: verify records inserted after signup
-- Count new users created after a timestamp (replace param)
SELECT COUNT(1) AS new_users_count
FROM users
WHERE created_at >= :since_timestamp; -- e.g., '2025-09-01 00:00:00'

-- 4b) Count enrollments for a student (post-signup verification)
SELECT COUNT(1) AS enrollments_for_student
FROM enrollments
WHERE student_id = :student_id;

-- 5) Sanity checks / QA spot checks
-- Duplicate username check (should be zero)
SELECT username, COUNT(*) AS cnt
FROM users
GROUP BY username
HAVING COUNT(*) > 1;

-- Recently signed up users list (limit example)
SELECT user_id, username, email, created_at
FROM users
ORDER BY created_at DESC
LIMIT 10;

-- 6) Edge-case validation: orphaned enrollments (enrollments with missing student or course)
-- Enrollments with no matching student
SELECT e.*
FROM enrollments e
LEFT JOIN students s ON e.student_id = s.student_id
WHERE s.student_id IS NULL;

-- Enrollments with no matching course
SELECT e.*
FROM enrollments e
LEFT JOIN courses c ON e.course_id = c.course_id
WHERE c.course_id IS NULL;
