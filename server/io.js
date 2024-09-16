 
 io.on('connection', (socket) => {
      console.log('A user connected');
   
  
  
      socket.on('join room', async (room) => {
        socket.join(room);
         console.log(`User joined room: ${room}`);
         try {
            const { conversationId } = req.params;
        
            // Fetch all messages for the specified conversation
            const getMessagesQuery = `
              SELECT m.message_id, m.sender_id, m.receiver_id, m.content, m.timestamp, u.username AS sender_username
              FROM messages m
              INNER JOIN users u ON m.sender_id = u.user_id
              WHERE m.conversation_id = ? 
              ORDER BY m.timestamp ASC`;
        
            const [messages] = await con.query(getMessagesQuery, [conversationId]);
        
            socket.emit('convomessages',messages);
          } catch (error) {
            console.error('Error retrieving messages:', error);
             
          }






      });
    
      socket.on('chat message', (msg) => {
        const room =  msg.conversationId;
        io.to(room).emit('chat message', msg);


        

        con.query('INSERT INTO messages SET ?', [
            {
            content: msg.content,
            sender_id: msg.sender_id,
            conversation_id: msg.conversationId,
            }
          ], (err, res, fields) => {
            if (err) throw err;
            console.log(res);
          });


         
          

      });


      socket.on('leave', (room) => {
        socket.leave(room);
       console.log(`User left room: ${room}`);
      });
      socket.on('disconnect', () => {
        console.log('User disconnected');
      });


      



       socket.on('disconnect', () => {
        console.log('User disconnected');
      });
       
  
   
    });
  
     
  
 

  export default io;