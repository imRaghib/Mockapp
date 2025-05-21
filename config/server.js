const express = require('express');
const app = express();
const sequelize = require('./config/db');
require('dotenv').config();

app.use(express.json());

// Sample route
app.get('/', (req, res) => {
  res.send('Backend is working!');
});

// Connect to database and start server
sequelize.authenticate()
  .then(() => {
    console.log('✅ Connected to MySQL successfully');
    app.listen(3000, () => {
      console.log('🚀 Server is running on http://localhost:3000');
    });
  })
  .catch((err) => {
    console.error('❌ Error connecting to DB:', err);
  });
