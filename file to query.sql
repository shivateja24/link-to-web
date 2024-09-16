use link_to
select * from events
select * from users
select * from users_courses

INSERT INTO events (course_id, event_name, event_date, event_start_time, event_end_time)
VALUES (
     1,
    'Exam',
    CURDATE(), -- Current date
    '10:30:00',
    '12:30:00'
);
