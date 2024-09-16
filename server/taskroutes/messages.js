import express from 'express';
import { JWT_SECRET } from '../middleware/verifytoken.js';
import bcrypt from 'bcrypt';
import verifyToken from '../middleware/verifytoken.js';
const taskrouter = express.Router();
import {con} from '../index.js';
import jwt from 'jsonwebtoken';

 
//get details of a conversation

taskrouter.get('/conversation/:conversationId',verifyToken, async (req, res) => {
  const { conversationId } = req.params;
  console.log("Got request to get conversation details",conversationId);

  try {
    // Fetch messages for the conversation
    con.query(
      'SELECT c.conversation_id, c.conversation_name, GROUP_CONCAT(CONCAT(u.username, " (", uc.user_id, ")") SEPARATOR ", ") AS user_names_and_ids FROM conversations c JOIN users_conversations uc ON c.conversation_id = uc.conversation_id JOIN users u ON uc.user_id = u.user_id WHERE c.conversation_id = ?',
      [conversationId],
      (error, result, fields) => {
        if (error) {
          console.error('Error fetching conversation details:', error);
        } else {
          console.log('Conversation details:', result);
                 
        res.json({           
          success: true,
          result,
        });
         }
      }
    );
          
 


    } 
    
    catch (error) {
      console.error('Error fetching messages:', error);
      res.status(500).json({
        success: false,
        message: 'Error fetching messages',
      });
    }
    

  });

//get all the conversations of a user
taskrouter.get('/conversationsWithUsers', verifyToken, async (req, res) => {
    const { user_id } = req.user;
    console.log("Got request to get conversations with users for user:", user_id);
    try {
      // Fetch conversations the user is part of along with details of users in each conversation
      con.query(
        `SELECT c.conversation_id, c.conversation_name,
                GROUP_CONCAT(u.user_id) AS user_ids, 
                GROUP_CONCAT(u.username) AS user_names
         FROM users_conversations uc 
         JOIN conversations c ON uc.conversation_id = c.conversation_id
         JOIN users u ON uc.user_id = u.user_id 
         WHERE uc.conversation_id IN (
           SELECT conversation_id FROM users_conversations WHERE user_id = ?
         )
         GROUP BY uc.conversation_id`,
        [user_id],
        (error, result, fields) => {
          if (error) {
            console.error('Error fetching conversations with users:', error);
            res.status(500).json({
              success: false,
              message: 'Error fetching conversations with users',
            });
          } else {
            console.log('Conversations with users:', result);
            res.json({
              success: true,
              conversations: result,
            });
          }
        }
      );
    } catch (error) {
      console.error('Error fetching conversations with users:', error);
      res.status(500).json({
        success: false,
        message: 'Error fetching conversations with users',
      });
    }
  });


//get the details of the user
taskrouter.get('/subjects', verifyToken, async (req, res) => {
     const userId = req.user.user_id;
    console.log("Got request to get user details for user:", userId);
  
    try {
      // Fetch user details
      con.query(
        'SELECT c.course_code,c.course_id, c.course_name FROM users_courses uc JOIN courses c ON uc.course_id = c.course_id WHERE uc.user_id = ?',[userId],
        (error, result, fields) => {
          if (error) {
            console.error('Error fetching user details:', error);
            res.status(500).json({
              success: false,
              message: 'Error fetching user details',
            });
          } else {
            console.log('subject details details:', result);
            res.json({
              success: true,
              subjects: result,
            });
          }
        }
      );
    } catch (error) {
      console.error('Error fetching user details:', error);
      res.status(500).json({
        success: false,
        message: 'Error fetching user details',
      });
    }
  });
//get today's events
taskrouter.get('/events/:date', verifyToken, async (req, res) => {
  const userId = req.user.user_id;
  const { date } = req.params; // Extract date parameter from URL

  console.log("Got request to get events for user:", userId, "on date:", date);

  try {
    // Fetch user's course IDs
    con.query(
      'SELECT course_id FROM users_courses WHERE user_id = ?',
      [userId],
      (error, result, fields) => {
        if (error) {
          console.error('Error fetching user courses:', error);
          res.status(500).json({
            success: false,
            message: 'Error fetching user courses',
          });
        } else {
          // Extract course IDs from the result
          const courseIds = result.map(course => course.course_id);

          if (courseIds.length === 0) {
            // If courseIds array is empty, return an empty result
            res.json({
              success: true,
              events: [],
            });
            return;
          }

          console.log('Course IDs:', courseIds);
 
           con.query('SELECT event_name, event_date, event_id, event_start_time, event_end_time, c.course_name FROM events LEFT JOIN courses c ON events.course_id = c.course_id WHERE events.course_id IN (?) AND DATE(event_date) = ?',
             [courseIds, date],
            (error, result, fields) => {
              if (error) {
                console.error("Error fetching events:", error);
                res.status(500).json({
                  success: false,
                  message: "Error fetching events",
                });
              } else {
                console.log("Events retrieved for the date required are:", result);
                res.json({
                  success: true,
                  events: result,
                });
              }
            }
          );
        }
      }
    );
  } catch (error) {
    console.error("Error fetching events for date:", date, ":", error);
    res.status(500).json({
      success: false,
      message: "Error fetching events for date",
    });
  }
});


  
  
export default taskrouter;


 