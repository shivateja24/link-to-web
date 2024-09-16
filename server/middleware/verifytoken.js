import jwt from 'jsonwebtoken'
export const JWT_SECRET = '12345678'
function verifyToken(req, res, next) {
    const authHeader = req.headers['authorization'];
    if (!authHeader) {
        return res.status(401).json({ message: 'Invalid token format' });
      }
    const [bearer, token] = authHeader.split(' ');
  
    if (!token) {
      return res.status(401).json({ message: 'Unauthorized' });
    }
     jwt.verify(token, JWT_SECRET, (err, decoded) => {
      if (err) {
        return res.status(401).json({ message: 'Invalid token' });
      }
      req.user = decoded;  
       next();
    });
  }


export default verifyToken;