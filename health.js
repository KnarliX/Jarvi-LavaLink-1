// Health check server for UptimeRobot
const http = require('http');
const fs = require('fs');
const path = require('path');

// Load HTML content for the status page
const statusHtml = fs.readFileSync(path.join(__dirname, 'status.html'), 'utf8');

const server = http.createServer((req, res) => {
  if (req.url === '/' || req.url === '/status') {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(statusHtml);
  } else if (req.url === '/health' || req.url === '/ping') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('OK');
  } else {
    // Serve status page for all other routes too
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(statusHtml);
  }
});

const port = process.env.HEALTH_PORT || 8080;
server.listen(port, () => {
  console.log(`Jarvi Lavalink health check server running on port ${port}`);
  console.log(`For UptimeRobot monitoring, use: http://[your-app-url]:${port}/`);
});