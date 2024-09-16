create database link_to
use link_to
CREATE TABLE users (
  user_id INT PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE messages (
  message_id INT AUTO_INCREMENT PRIMARY KEY,
  sender_id INT,
  conversation_id INT,
  content TEXT NOT NULL,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES users(user_id)
 );
  CREATE TABLE event_messages (
  event_message_id INT AUTO_INCREMENT PRIMARY KEY,
  sender_id INT,
  receiver_id INT,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES users(user_id),
  FOREIGN KEY (receiver_id) REFERENCES users(user_id)
 );
 
 CREATE TABLE conversations (
  conversation_id INT AUTO_INCREMENT PRIMARY KEY,
  conversation_name VARCHAR(255) NOT NULL
 );

CREATE TABLE users_conversations (
  user_id INT,
  conversation_id INT,
  PRIMARY KEY (user_id, conversation_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (conversation_id) REFERENCES conversations(conversation_id)
);

CREATE TABLE courses (
  course_id INT AUTO_INCREMENT PRIMARY KEY,
  course_name VARCHAR(255) NOT NULL
 );
 
 CREATE TABLE users_courses (
  user_id INT,
  course_id INT,
  PRIMARY KEY (user_id, course_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);



 
CREATE TABLE users_messages (
  user_id INT,
  message_id INT,
  conversation_id INT,
  PRIMARY KEY (user_id, message_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (message_id) REFERENCES messages(message_id),
  FOREIGN KEY (conversation_id) REFERENCES conversations(conversation_id)
);
 
 

 

CREATE TABLE event_messages (
  event_message_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  description TEXT NOT NULL,
  event_date DATE,
  event_time TIME,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);
 

INSERT INTO courses (course_name) VALUES
('ECPC18'),
('ECPE19'),
('ECPC19'),
('ECPE20'),
('ECPE21');
 
 select * from courses
 select * from users_courses 
 Alter table messages
 add column is_event bool default(false)
Insert into users_courses(user_id,course_id) values(108121071,5)
show tables
select * from conversations




///LYNK

CREATE DATABASE LYNK;
USE LYNK;

CREATE TABLE SUBJECTS(
	Subject_id INT AUTO_INCREMENT PRIMARY KEY,
    Subject_Name VARCHAR(50) UNIQUE,
    Subject_Code VARCHAR(10) UNIQUE,
    Subject_Type VARCHAR(20),
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES SUBJECTS(Subject_id)
);

CREATE TABLE EVENTS(
	Event_id INT AUTO_INCREMENT PRIMARY KEY,
    Subject_id Int,
    Event_type VARCHAR(30),
    Event_date DATE,
    Event_time TIME,
	FOREIGN KEY (Subject_id) REFERENCES SUBJECTS(Subject_id)

);
CREATE TABLE COURSES(
	Course_id INT AUTO_INCREMENT PRIMARY KEY,
    Course_Name VARCHAR(10)
);

CREATE TABLE STUDENT_INFO(
	 
    Name VARCHAR(40),
    Roll_Number INT PRIMARY KEY,
    Course_id INT,
    Year INT,
    Specialization VARCHAR(30),
	FOREIGN KEY (Course_id) REFERENCES COURSES(Course_id)
);

CREATE TABLE REGISTRATION (
    Registration_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_number INT,
    Subject_id INT,
    UNIQUE(roll_number,Subject_id),
    FOREIGN KEY (roll_number) REFERENCES STUDENT_INFO(roll_number),
    FOREIGN KEY (Subject_id) REFERENCES SUBJECTS(Subject_id)
);


INSERT INTO SUBJECTS (Subject_Name, Subject_Code, Parent_id) 
VALUES 
('Antennas', 'ECPC12', NULL), 
('Wireless communications', 'ECPC14', NULL), 
('Analog communications', 'ECPC16', NULL), 
('Digital communications', 'ECPC18', NULL), 
('Semiconductor physics', 'ECPE20', NULL), 
('EM waves', 'ECLR22', NULL), 
('Microwaves Laboratory', 'ECLR24', NULL), 
('Fiber optics Laboratory', 'ECPE26', NULL);



USE Lynk;

INSERT INTO COURSES(course_name) values 
('BTECH'),('MTECH'),('PHD');

INSERT INTO STUDENT_INFO (Name, Roll_Number, Course_id, Specialization) VALUES
('Arjun', 108121001, 1, NULL),
('Diya', 108121002, 1, NULL),
('Rohan', 108121003, 1, NULL),
('Ananya', 108121004, 1, NULL),
('Aryan', 108121005, 1, NULL),
('Nisha', 108121006, 1, NULL),
('Virat', 108121007, 1, NULL),
('Pooja', 108121008, 1, NULL),
('Rahul', 108121009, 1, NULL),
('Aisha', 108121010, 1, NULL),
('Kabir', 108121011, 1, NULL),
('Ishika', 108121012, 1, NULL),
('Krish', 108121013, 1, NULL),
('Simran', 108121014, 1, NULL),
('Rajat', 108121015, 1, NULL),
('Meera', 108121016, 1, NULL),
('Akash', 108121017, 1, NULL),
('Kavya', 108121018, 1, NULL),
('Vikram', 108121019, 1, NULL),
('Riya', 108121020, 1, NULL),
('Aarush', 108121021, 1, NULL),
('Anika', 108121022, 1, NULL),
('Yash', 108121023, 1, NULL),
('Natasha', 108121024, 1, NULL),
('Abhinav', 108121025, 1, NULL),
('Sanya', 108121026, 1, NULL),
('Surya', 108121027, 1, NULL),
('Avani', 108121028, 1, NULL),
('Arnav', 108121029, 1, NULL),
('Priya', 108121030, 1, NULL),
('Vihaan', 108121031, 1, NULL),
('Zara', 108121032, 1, NULL),
('Aditya', 108121033, 1, NULL),
('Esha', 108121034, 1, NULL),
('Kabir Sharma', 108121035, 1, NULL),
('Ishita Khan', 108121036, 1, NULL),
('Rishi Kumar', 108121037, 1, NULL),
('Aanya Srivastav', 108121038, 1, NULL),
('Arusha Malhotra', 108121039, 1, NULL),
('Ved Biswas', 108121040, 1, NULL),
('Tanvi Saha', 108121041, 1, NULL),
('Aditya Choudhary', 108121042, 1, NULL),
('Sania Patel', 108121043, 1, NULL),
('Advait Sharma', 108121044, 1, NULL),
('Trisha Khan', 108121045, 1, NULL),
('Arisha Kumar', 108121046, 1, NULL),
('Arnavi Srivastav', 108121047, 1, NULL),
('Pranav Malhotra', 108121048, 1, NULL),
('Nandini Biswas', 108121049, 1, NULL),
('Shaan Saha', 108121050, 1, NULL);
 


SET foreign_key_checks = 0;
INSERT INTO REGISTRATION (roll_number, Subject_id) VALUES
(108121001, 6), (108121001, 4), (108121001, 1),
(108121002, 3), (108121002, 4), (108121002, 6),
(108121003, 1), (108121003, 6), (108121003, 3),
(108121004, 5), (108121004, 1), (108121004, 4),
(108121005, 3), (108121005, 1), (108121005, 5),
(108121006, 5), (108121006, 6), (108121006, 2),
(108121007, 5), (108121007, 1), (108121007, 3),
(108121008, 4), (108121008, 6), (108121008, 3),
(108121009, 2), (108121009, 1), (108121009, 5),
(1081210010, 6), (1081210010, 3), (1081210010, 5),
(1081210011, 1), (1081210011, 2), (1081210011, 4),
(1081210012, 4), (1081210012, 3), (1081210012, 5),
(1081210013, 6), (1081210013, 5), (1081210013, 3),
(1081210014, 2), (1081210014, 5), (1081210014, 4),
(1081210015, 2), (1081210015, 4), (1081210015, 6),
(1081210016, 2), (1081210016, 5), (1081210016, 6),
(1081210017, 2), (1081210017, 3), (1081210017, 4),
(1081210018, 1), (1081210018, 5), (1081210018, 3),
(1081210019, 1), (1081210019, 2), (1081210019, 4),
(1081210020, 1), (1081210020, 4), (1081210020, 6),
(108121021, 5), (108121021, 2), (108121021, 4),
(108121022, 3), (108121022, 2), (108121022, 5),
(108121023, 5), (108121023, 4), (108121023, 6),
(108121024, 5), (108121024, 3), (108121024, 4),
(108121025, 3), (108121025, 4), (108121025, 6),
(108121026, 4), (108121026, 1), (108121026, 5),
(108121027, 1), (108121027, 5), (108121027, 4),
(108121028, 6), (108121028, 4), (108121028, 2),
(108121029, 5), (108121029, 2), (108121029, 1),
(108121030, 5), (108121030, 2), (108121030, 4),
(108121031, 2), (108121031, 5), (108121031, 4),
(1081210032, 2), (1081210032, 4), (1081210032, 6),
(1081210033, 2), (1081210033, 6), (1081210033, 1),
(1081210034, 6), (1081210034, 5), (1081210034, 3),
(1081210035, 2), (1081210035, 5), (1081210035, 3),
(1081210036, 3), (1081210036, 2), (1081210036, 5),
(1081210037, 2), (1081210037, 5), (1081210037, 3),
(1081210038, 5), (1081210038, 6), (1081210038, 3),
(1081210039, 3), (1081210039, 1), (1081210039, 4),
(1081210040, 2), (1081210040, 6), (1081210040, 4),
(1081210041, 4), (1081210041, 1), (1081210041, 2),
(1081210042, 6), (1081210042, 3), (1081210042, 4),
(1081210043, 6), (1081210043, 4), (1081210043, 3),
(1081210044, 1), (1081210044, 3), (1081210044, 6),
(1081210045, 5), (1081210045, 2), (1081210045, 4),
(1081210046, 4), (1081210046, 6), (1081210046, 5),
(1081210047, 4), (1081210047, 1), (1081210047, 5),
(1081210048, 1), (1081210048, 6), (1081210048, 3),
(1081210049, 2), (1081210049, 3), (1081210049, 6),
(1081210050, 6), (1081210050, 2), (1081210050, 5);


select * from subjects
select * from events
INSERT INTO EVENTS (Subject_id, Event_type, Event_date, Event_time)
VALUES
    (1, 'Exam', '2024-03-15', '09:00:00'),
    (2, 'Assignment', '2024-03-18', '14:30:00'),
    (3, 'Quiz', '2024-03-20', '10:00:00'),
    (4, 'Presentation', '2024-03-22', '15:45:00'),
    (5, 'Lab Session', '2024-03-25', '11:30:00'),
    (6, 'Midterm', '2024-03-28', '13:00:00'),
    (1, 'Project Deadline', '2024-04-02', '16:30:00'),
    (2, 'Discussion', '2024-04-05', '12:15:00'),
    (3, 'Exam', '2024-04-08', '10:30:00'),
    (4, 'Quiz', '2024-04-10', '14:00:00'); -- corrected the time value


 ALTER TABLE EVENTS CHANGE COLUMN event_data event_date DATE;


SET foreign_key_checks = 0;
INSERT INTO REGISTRATION (roll_number, Subject_id) VALUES
(108121001, 6), (108121001, 4), (108121001, 1),
(108121002, 3), (108121002, 4), (108121002, 6),
(108121003, 1), (108121003, 6), (108121003, 3),
(108121004, 5), (108121004, 1), (108121004, 4),
(108121005, 3), (108121005, 1), (108121005, 5),
(108121006, 5), (108121006, 6), (108121006, 2),
(108121007, 5), (108121007, 1), (108121007, 3),
(108121008, 4), (108121008, 6), (108121008, 3),
(108121009, 2), (108121009, 1), (108121009, 5),
(108121010, 6), (108121010, 3), (108121010, 5),
(108121011, 1), (108121011, 2), (108121011, 4),
(108121012, 4), (108121012, 3), (108121012, 5),
(108121013, 6), (108121013, 5), (108121013, 3),
(108121014, 2), (108121014, 5), (108121014, 4),
(108121015, 2), (108121015, 4), (108121015, 6),
(108121016, 2), (108121016, 5), (108121016, 6),
(108121017, 2), (108121017, 3), (108121017, 4),
(108121018, 1), (108121018, 5), (108121018, 3),
(108121019, 1), (108121019, 2), (108121019, 4),
(108121020, 1), (108121020, 4), (108121020, 6),
(108121021, 5), (108121021, 2), (108121021, 4),
(108121022, 3), (108121022, 2), (108121022, 5),
(108121023, 5), (108121023, 4), (108121023, 6),
(108121024, 5), (108121024, 3), (108121024, 4),
(108121025, 3), (108121025, 4), (108121025, 6),
(108121026, 4), (108121026, 1), (108121026, 5),
(108121027, 1), (108121027, 5), (108121027, 4),
(108121028, 6), (108121028, 4), (108121028, 2),
(108121029, 5), (108121029, 2), (108121029, 1),
(108121030, 5), (108121030, 2), (108121030, 4),
(108121031, 2), (108121031, 5), (108121031, 4),
(108121032, 2), (108121032, 4), (108121032, 6),
(108121033, 2), (108121033, 6), (108121033, 1),
(108121034, 6), (108121034, 5), (108121034, 3),
(108121035, 2), (108121035, 5), (108121035, 3),
(108121036, 3), (108121036, 2), (108121036, 5),
(108121037, 2), (108121037, 5), (108121037, 3),
(108121038, 5), (108121038, 6), (108121038, 3),
(108121039, 3), (108121039, 1), (108121039, 4),
(108121040, 2), (108121040, 6), (108121040, 4),
(108121041, 4), (108121041, 1), (108121041, 2),
(108121042, 6), (108121042, 3), (108121042, 4),
(108121043, 6), (108121043, 4), (108121043, 3),
(108121044, 1), (108121044, 3), (108121044, 6),
(108121045, 5), (108121045, 2), (108121045, 4),
(108121046, 4), (108121046, 6), (108121046, 5),
(108121047, 4), (108121047, 1), (108121047, 5),
(108121048, 1), (108121048, 6), (108121048, 3),
(108121049, 2), (108121049, 3), (108121049, 6),
(108121050, 6), (108121050, 2), (108121050, 5);

truncate registration


SELECT 
    STUDENT_INFO.Name AS Student_Name,
    EVENTS.Event_type AS Event_Type,
    SUBJECTS.Subject_Name AS Subject_Name,
    EVENTS.Event_date AS Event_Date
FROM 
    STUDENT_INFO
JOIN 
    REGISTRATION ON STUDENT_INFO.Roll_Number = REGISTRATION.roll_number
JOIN 
    SUBJECTS ON REGISTRATION.Subject_id = SUBJECTS.Subject_id
JOIN 
    EVENTS ON SUBJECTS.Subject_id = EVENTS.Subject_id
WHERE 
    EVENTS.Event_type LIKE '%Exam%'
    AND EVENTS.Event_date < '2024-03-20';
    
    
SELECT
  s.Name,
  e.Event_type,
  s.Subject_Name
FROM EVENTS AS e
JOIN SUBJECTS AS s
  ON e.Subject_id = s.Subject_id
JOIN REGISTRATION AS r
  ON s.Subject_id = r.Subject_id
JOIN STUDENT_INFO AS s
  ON r.roll_number = s.Roll_Number
WHERE
  e.Event_date BETWEEN '2024-03-01' AND '2024-03-31'
  AND e.Event_time BETWEEN '10:00:00' AND '11:00:00';
  
  
rename table student_info to user_info

SELECT DISTINCT
  U.Name
FROM user_info AS U
JOIN REGISTRATION AS R
  ON U.Roll_Number = R.roll_number
JOIN SUBJECTS AS S
  ON R.Subject_id = S.Subject_id
LEFT JOIN EVENTS AS E
  ON S.Subject_id = E.Subject_id
WHERE


select * from subjects

alter table subjects drop column subject_type



INSERT INTO SUBJECTS (
  Subject_Name,
  Subject_Code,
  parent_id
)
SELECT
  Subject_Name,
  Subject_Code || "_batch_" || CASE
    WHEN mod(Roll_Number, 25) <= 12
    THEN 1
    ELSE 2
  END,
  Subject_id
FROM subjects
JOIN user_info
  ON subjects.subject_id = user_info.roll_number
WHERE
  user_info.roll_number BETWEEN 108121001 AND 108121050;
  
select * from subjects

INSERT INTO SUBJECTS (
    Subject_Name,
    Subject_Code,
    parent_id
)
SELECT
    Subject_Name,
    CONCAT(Subject_Code, '_batch_', CASE WHEN MOD(Roll_Number, 25) <= 12 THEN 1 ELSE 2 END),
    Subject_id
FROM
    subjects
JOIN
    user_info
ON
    subjects.subject_id = user_info.roll_number
WHERE
    user_info.roll_number BETWEEN 108121001 AND 108121050;

select * from subjects

SET @parent_id = (SELECT Subject_id FROM SUBJECTS WHERE Subject_Code = 'ECLR24');


 INSERT INTO SUBJECTS (Subject_Name, Subject_Code, parent_id) VALUES
('ECLR24 batch_1', 'ECLR24_1', @parent_id),
('ECLR24 batch_2', 'ECLR24_2', @parent_id);


SET @batch_1_subject_id = (SELECT Subject_id FROM SUBJECTS WHERE Subject_Code = 'ECLR24_1');
SET @batch_2_subject_id = (SELECT Subject_id FROM SUBJECTS WHERE Subject_Code = 'ECLR24_2');

INSERT INTO REGISTRATION (roll_number, Subject_id)
SELECT roll_number, @batch_1_subject_id
FROM user_info
WHERE roll_number BETWEEN 108121001 AND 108121025;


INSERT INTO REGISTRATION (roll_number, Subject_id)
SELECT roll_number, @batch_2_subject_id
FROM user_info
WHERE roll_number BETWEEN 108121026 AND 108121050;



select * from subjects

SELECT
  U.Name AS Student_Name
FROM user_info AS U
JOIN REGISTRATION AS R
  ON U.Roll_Number = R.roll_number
JOIN SUBJECTS AS S
  ON S.Subject_id = R.Subject_id
WHERE
  S.Subject_Name LIKE "%ECLR24batch_1%" AND S.parent_id IS NOT NULL;


SELECT DISTINCT
  u.Name
FROM user_info AS u
INNER JOIN REGISTRATION AS r
  ON u.Roll_Number = r.roll_number
INNER JOIN SUBJECTS AS s
  ON r.Subject_id = s.Subject_id
WHERE
  s.Subject_Code LIKE 'ECLR24%' AND s.Subject_Name LIKE '%1';
 DELETE FROM registration 
WHERE registration_id IN (
    SELECT sub.registration_id 
    FROM (SELECT registration_id FROM registration WHERE subject_id = 11 OR subject_id = 12) AS sub
);


select * from subjects
 
UPDATE EVENTS
SET Event_date = '2024-03-15'
WHERE Subject_id = (
    SELECT Subject_id
    FROM SUBJECTS
    WHERE Subject_Name = 'Antennas'
)
AND Event_type = 'Exam';

SELECT
  *
FROM timetable
WHERE
  Event = 'Exam' AND (
    Start_Date = '2024-03-18' OR End_Date = '2024-03-18'
  ) AND (
    Event_Date = DATE_ADD(CURDATE(), INTERVAL 2 DAY)
  );
use lynk
UPDATE EVENTS
SET Event_date = '2024-09-04', Event_type = 'Exam'
WHERE Subject_id = (SELECT Subject_id FROM SUBJECTS WHERE Subject_Code = 'ECPC12')
  AND Event_type = 'Exam';
select * from registration
select * from events         
UPDATE EVENTS SET Event_date = '2024-09-04', Event_time = '14:17:15'
WHERE Subject_id IN (SELECT Subject_id FROM SUBJECTS WHERE Subject_Name = 'Antennas');
Insert into events(subject_id,event_type,event_date) values 
(6,'Exam','2024-03-31')

show tables
use lynk
select * from subjects
select * from registration
select * from courses
select * from events  
select * from events where event_id = 6
SELECT roll_number, registration.subject_id, subjects.subject_name, subjects.subject_code
FROM registration
LEFT JOIN subjects ON registration.subject_id = subjects.subject_id where roll_number = 108121001
