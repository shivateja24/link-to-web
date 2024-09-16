CREATE DATABASE LYNK_To;
USE LYNK_To;

CREATE TABLE subjects (
    subject_code VARCHAR(10) PRIMARY KEY,
    subject_name VARCHAR(100),
    parent_id INT,
    prof_name VARCHAR(100)
);

CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_code VARCHAR(10),
    event_type VARCHAR(50),
    event_date DATE,
    event_time TIME,
    event_description TEXT,
    event_message TEXT,
    FOREIGN KEY (subject_code) REFERENCES subjects(subject_code)
);

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(30),
    password VARCHAR(30),
    IS_CR BOOLEAN
);

CREATE TABLE registrations (
    user_id INT,
    subject_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_code),
    PRIMARY KEY (user_id, subject_id)
);

CREATE TABLE messages{
  message_id INT AUTO_INCREMENT PRIMARY KEY,
  message TEXT NOT NULL}
