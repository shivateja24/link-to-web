import express from 'express';
import { JWT_SECRET } from '../middleware/verifytoken.js';
import bcrypt from 'bcrypt';
import verifyToken from '../middleware/verifytoken.js';
const authrouter = express.Router();
import {con} from '../index.js';
import jwt from 'jsonwebtoken';

authrouter.post('/signup', (req, res) => {
    const { rollNumber, username, password, courses } = req.body;
  
    // Hash the password
    bcrypt.hash(password, 10, (err, hashedPassword) => {
      if (err) {
        console.error('Error hashing password:', err);
        res.status(500).json({ message: 'Internal Server Error' });
        return;
      }
  
      // Check if user with the given user_id already exists
      con.query('SELECT * FROM users WHERE user_id = ?', [rollNumber], (err, result) => {
        if (err) {
          console.error('Error checking if user exists:', err);
          res.status(500).json({ message: 'Internal Server Error' });
          return;
        }
  
        if (result.length !== 0) {
          res.json({ message: 'User with given user_id already exists' });
          return;
        }
  
        // If user with the given user_id doesn't exist, proceed with signup
        con.query('SELECT * FROM users WHERE username = ? ', [username], (err, result) => {
          if (err) {
            console.error('Error checking if username exists:', err);
            res.status(500).json({ message: 'Internal Server Error' });
            return;
          }
  
          if (result.length !== 0) {
            res.json({ message: 'User already present with given username' });
            return;
          }
  
          con.query('INSERT INTO users SET ?', { user_id: rollNumber, username, password: hashedPassword }, (err, resu) => {
            if (err) {
              console.error('Error inserting user:', err);
              res.status(500).json({ message: 'Internal Server Error' });
              return;
            }
  
            // Insert courses into users_courses table
            courses.forEach(course => {
              con.query('INSERT INTO users_courses SET ?', { user_id: rollNumber, course_id: course }, (err) => {
                if (err) {
                  console.error('Error adding course:', err);
                  res.status(500).json({ message: 'Internal Server Error' });
                  return;
                }
              });
            });
  
            res.json({ message: 'User added successfully' });
          });
        });
      });
    });
  });
  
  // Login route
authrouter.post('/login', (req, res) => {
    const { username, password } = req.body;
  
    con.query('SELECT * FROM users WHERE username = ?', [username], (err, result) => {
      if (err) {
        console.error('Error executing query:', err);
        res.status(500).json({ message: 'Internal Server Error' });
        return;
      }
  
      if (result.length === 0) {
        res.json({ message: 'User not found' });
        return;
      }
  
      const user = result[0];
  
      // Compare hashed passwords
      bcrypt.compare(password, user.password, (err, passwordMatch) => {
        if (err) {
          console.error('Error comparing passwords:', err);
          res.status(500).json({ message: 'Internal Server Error' });
          return;
        }
  
        if (!passwordMatch) {
          res.json({ message: 'Incorrect password' });
          return;
        }
  
        const jwt_token = jwt.sign(
          { user_id: user.user_id, username: user.username },
          JWT_SECRET,
          { expiresIn: '1h' } // Token expires in 1 hour
        );
  
        console.log(user);
  
        res.json({ message: 'Login successful', jwt_token, user });
  
     
      });
    });
  });
  
export default authrouter;