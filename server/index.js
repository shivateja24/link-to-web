import express from 'express';
import cors from 'cors';
const app = express();
app.use(cors());
                     
import http from 'http';
const server = http.createServer(app);
import { Server } from 'socket.io';

const io = new Server(server, { cors: { origin: '*' } });

const PORT = 3000;
import taskrouter from './taskroutes/messages.js';
import authrouter from './authroutes/auth.js';
import mysql from 'mysql';

export const con = mysql.createConnection({
  host: 'localhost',
  port: '3050',
  user: 'root',
  password: 'Shiva242004',
  database: 'link_to',
});

io.on('connection', (socket) => {
  console.log('A user connected');

  socket.on('join room', async (room) => {
    socket.join(room.conversationId); // Use room.conversationId to join the specific room
    console.log(`User joined room: ${room.conversationId}`);

    try {
      const { conversationId } = room;
      const getMessagesQuery = `
        SELECT m.message_id, m.sender_id, m.content, m.timestamp, m.is_event, u.username AS sender_username
        FROM messages m
        INNER JOIN users u ON m.sender_id = u.user_id
        WHERE m.conversation_id = ? 
        ORDER BY m.timestamp ASC`;

      con.query(getMessagesQuery, [conversationId], (err, results, fields) => {
        if (err) throw err;
        console.log('The conversation messages are', results);
        socket.emit('convomessages', { messages: results });
      });
    } catch (error) {
      console.error('Error retrieving messages:', error);
    }
  });

  socket.on('send message', (msg) => {
    const room = msg.conversationId;
    console.log('message received', msg, 'Inroom', room);
    msg.sender_id = msg.userId;
    const sqlTimestamp = new Date().toISOString();
    msg.timestamp = sqlTimestamp;
    const insertMessageQuery = `
      INSERT INTO messages (content, sender_id, conversation_id, is_event)
      VALUES (?, ?, ?, ?)`;

    con.query(
      insertMessageQuery,
      [msg.content, msg.userId, msg.conversationId, msg.is_event],
      (err, res, fields) => {
        if (err) throw err;
        console.log(res);
        msg.insert_id = res.insertId;  
        msg.sender_username = msg.sender_username;
        io.to(room).emit('receivemessage', msg);
      }
    );
  });

  /* socket.on('get schedule', (userId,date) => { // Assuming userId is passed as an argument
    console.log('got request to get schedule for user:', userId, 'on date:',date);
    const query = `
      SELECT e.event_id, e.course_id, e.event_name, e.event_date, e.event_start_time, e.event_end_time
      FROM events e
      JOIN courses c ON e.course_id = c.course_id
      JOIN users_courses uc ON c.course_id = uc.course_id
      WHERE uc.user_id = ? and e.event_date = ?
      ORDER BY e.event_date ASC, e.event_start_time ASC`;
    
    con.query(query, [userId,date], (err, result) => {
        if (err) {
            console.error('Error fetching schedule:', err);
            // Handle the error, emit an error event or send an error message to the client
        } else {
            // Emit the schedule back to the client
            socket.emit('schedule', result);
        }
    });
}); */


  socket.on('leave', (room) => {
    socket.leave(room);
    console.log(`User left room: ${room}`);
  });

  socket.on('disconnect', () => {
    console.log('User disconnected');
  });
});

con.connect(function (err) {
  if (err) {
    console.log(err);
  } else console.log('Connected to database!');
});

con.query('SELECT * FROM users', function (error, results, fields) {
  if (error) throw error;
  console.log(results);
});

app.use(express.json());
app.use(authrouter);
app.use(taskrouter);

server.listen(PORT, () => {
  console.log('server started');
});

export default server;
