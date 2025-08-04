CREATE database student_db;
USE student_db;


-- Create classes table
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(20),
    section VARCHAR(5)
);

INSERT INTO classes VALUES
(1, 'CSE-A', 'A'),
(2, 'CSE-B', 'B'),
(3, 'ECE-A', 'A'),
(4, 'ECE-B', 'B'),
(5, 'EEE-A', 'A'),
(6, 'IT-A', 'A'),
(7, 'MECH-A', 'A'),
(8, 'CIVIL-A', 'A'),
(9, 'AI&DS-A', 'A'),
(10, 'AIML-A', 'A');




-- Create teachers table
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50)
);

INSERT INTO teachers VALUES
(1, 'Dr. Ramesh Kumar', 'ramesh@college.edu'),
(2, 'Ms. Priya Sharma', 'priya@college.edu'),
(3, 'Mr. Vinod R.', 'vinod@college.edu'),
(4, 'Mrs. Lakshmi M.', 'lakshmi@college.edu'),
(5, 'Dr. Amit P.', 'amit@college.edu'),
(6, 'Dr. Sneha K.', 'sneha@college.edu'),
(7, 'Mr. Arjun N.', 'arjun@college.edu'),
(8, 'Mrs. Kiran S.', 'kiran@college.edu'),
(9, 'Mr. Sameer A.', 'sameer@college.edu'),
(10, 'Ms. Anjali J.', 'anjali@college.edu');

-- Create subjects table (no foreign key to teachers)
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50),
    teacher_id INT
);

INSERT INTO subjects VALUES
(1, 'Mathematics', 1),
(2, 'Physics', 2),
(3, 'Chemistry', 3),
(4, 'Computer Science', 4),
(5, 'English', 5),
(6, 'Machine Learning', 6),
(7, 'Data Structures', 7),
(8, 'Networks', 8),
(9, 'AI', 9),
(10, 'IoT', 10);


-- Create students table (no foreign key to classes)
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    roll_number VARCHAR(10),
    class_id INT,
    email VARCHAR(50)
);

INSERT INTO students VALUES
(101, 'Arjun Kumar', 'CSE001', 1, 'arjun@students.edu'),
(102, 'Meera Das', 'CSE002', 1, 'meera@students.edu'),
(103, 'Ravi Verma', 'CSE003', 2, 'ravi@students.edu'),
(104, 'Divya Nair', 'ECE001', 3, 'divya@students.edu'),
(105, 'Nikhil Reddy', 'ECE002', 3, 'nikhil@students.edu'),
(106, 'Sneha Iyer', 'EEE001', 5, 'sneha@students.edu'),
(107, 'Rahul Singh', 'MECH001', 7, 'rahul@students.edu'),
(108, 'Pooja Menon', 'IT001', 6, 'pooja@students.edu'),
(109, 'Vikram Shah', 'AI001', 9, 'vikram@students.edu'),
(110, 'Nisha Joseph', 'ML001', 10, 'nisha@students.edu');


-- Create attendance table (no foreign keys to students or subjects)
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    date DATE,
    status VARCHAR(10)
);

INSERT INTO attendance VALUES
(1, 101, 1, '2025-08-01', 'Present'),
(2, 102, 1, '2025-08-01', 'Absent'),
(3, 103, 2, '2025-08-01', 'Present'),
(4, 104, 3, '2025-08-01', 'Present'),
(5, 105, 3, '2025-08-01', 'Absent'),
(6, 106, 5, '2025-08-01', 'Present'),
(7, 107, 4, '2025-08-01', 'Present'),
(8, 108, 6, '2025-08-01', 'Absent'),
(9, 109, 9, '2025-08-01', 'Present'),
(10, 110, 10, '2025-08-01', 'Present');

SELECT 
    students.name,
    ROUND(
        SUM(CASE WHEN attendance.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(attendance.attendance_id),
        2
    ) AS attendance_percentage
FROM 
    attendance
JOIN 
    students ON attendance.student_id = students.student_id
WHERE 
    students.student_id = 101
GROUP BY 
    students.name;


SELECT 
    subj.subject_name,
    COUNT(*) AS total_classes,
    SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS attended
FROM 
    attendance a
JOIN subjects subj ON a.subject_id = subj.subject_id
WHERE 
    a.student_id = 101
GROUP BY 
    subj.subject_name;
    
    
SELECT 
    s.name,
    a.date,
    a.status
FROM 
    attendance a
JOIN students s ON a.student_id = s.student_id
WHERE 
    a.subject_id = 202 AND a.date = '2025-08-04';






