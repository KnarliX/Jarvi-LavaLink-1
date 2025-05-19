// Simple Express server to create a health endpoint for UptimeRobot
const express = require('express');
const app = express();
const port = process.env.HEALTH_PORT || 8080;
const fetch = require('node-fetch');

const mainServerUrl = `http://localhost:${process.env.SERVER_PORT || 80}`;
const password = process.env.LAVALINK_SERVER_PASSWORD || 'Jarvi1.0';

// Health endpoint for UptimeRobot
app.get('/', async (req, res) => {
  try {
    // Check if Lavalink is running
    const response = await fetch(`${mainServerUrl}/version`, {
      headers: {
        'Authorization': password
      }
    });
    
    if (response.ok) {
      const data = await response.json();
      res.send(`Jarvi Lavalink Server is running! Version: ${data.version}`);
    } else {
      res.status(500).send('Lavalink server is not responding properly');
    }
  } catch (error) {
    res.status(500).send('Error checking Lavalink server: ' + error.message);
  }
});

app.listen(port, () => {
  console.log(`Health check server running on port ${port}`);
});