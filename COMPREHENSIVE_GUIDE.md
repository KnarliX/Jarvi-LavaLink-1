# Jarvi Lavalink Server - Comprehensive Setup Guide

This guide provides detailed instructions for deploying and configuring your Lavalink server for the "Jarvi" Discord music bot on render.com's free plan.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Deployment Options](#deployment-options)
   - [One-Click Deployment](#one-click-deployment)
   - [Manual Deployment](#manual-deployment)
3. [Configuration](#configuration)
4. [Connecting Your Bot](#connecting-your-bot)
5. [Monitoring & Maintenance](#monitoring--maintenance)
6. [Troubleshooting](#troubleshooting)
7. [Advanced Configuration](#advanced-configuration)

## Prerequisites

Before you begin, make sure you have:
- A render.com account (free plan is sufficient)
- A Discord bot with Lavalink client capabilities
- Basic knowledge of Discord bot development

## Deployment Options

### One-Click Deployment

1. Fork this repository to your GitHub account.
2. Visit your fork and click the "Deploy to Render" button in the README.
3. Connect your Render account if prompted.
4. Render will automatically detect the configuration files and deploy your Lavalink server.

### Manual Deployment

1. Log in to your [render.com](https://dashboard.render.com/) account.
2. Click "New" and select "Web Service".
3. Connect to your GitHub account and select your forked repository.
4. Configure the service with these settings:
   - **Name**: jarvi-lavalink (or your preferred name)
   - **Environment**: Docker
   - **Branch**: main (or your default branch)
   - **Plan**: Free
   - **Region**: Choose the region closest to your Discord bot's host location.
5. Add these environment variables (click "Advanced" and then "Add Environment Variable"):
   - `SERVER_PORT`: 80
   - `LAVALINK_SERVER_PASSWORD`: Jarvi1.0 (or your preferred password)
   - `_JAVA_OPTIONS`: -Xmx512m -Xms128m
6. Click "Create Web Service".

## Configuration

The Lavalink server comes pre-configured with settings optimized for render.com's free plan. These settings balance performance and resource usage:

- **Memory Usage**: Configured to stay within the free plan's limits
- **Audio Quality**: Set to a good balance between quality and performance
- **Port Configuration**: Automatically adapts to render.com's assigned port
- **Logging**: Minimized to reduce disk usage

## Connecting Your Bot

Once your Lavalink server is deployed, you'll need to configure your Jarvi Discord bot to connect to it.

### Connection Details
```javascript
// Example configuration for Discord.js with Erela.js
const nodes = [
  {
    host: "your-app-name.onrender.com", // Replace with your render.com URL
    port: 443, // Use 443 for HTTPS/SSL
    password: "Jarvi1.0", // Must match LAVALINK_SERVER_PASSWORD
    secure: true // Important for render.com deployments
  }
];
```

### Client Libraries

Jarvi bot can connect to this Lavalink server using any standard Lavalink client library:

- [Erela.js](https://github.com/MenuDocs/erela.js) (Node.js)
- [Wavelink](https://github.com/PythonistaGuild/Wavelink) (Python)
- [Lavalink-Client](https://github.com/freyacodes/lavalink-client) (Java)
- [Lavalink.kt](https://github.com/DRSchlaubi/lavalink.kt) (Kotlin)

## Monitoring & Maintenance

### Checking Server Status

You can check if your Lavalink server is running by visiting:
`https://your-app-name.onrender.com/version`

If working correctly, it should return version information in JSON format.

### Viewing Logs

1. Go to your service in the Render dashboard
2. Click on "Logs" in the left sidebar
3. Select "All" to see all logs or filter as needed

### Restarting the Server

If you need to restart the server:
1. Go to your service in the Render dashboard
2. Click "Manual Deploy" > "Deploy latest commit"

## Troubleshooting

### Common Issues

1. **Connection Refused**
   - Make sure you're using `secure: true` in your client
   - Verify your bot is using the correct hostname and port (443)

2. **Authentication Failed**
   - Check that the password in your bot configuration matches the `LAVALINK_SERVER_PASSWORD` environment variable

3. **Server Not Responding**
   - The free plan may have put your service to sleep. The first request might take longer to wake it up.
   - Check the Render logs for any errors

4. **Audio Quality Issues**
   - Consider adjusting the audio quality settings in `application.yml` if you upgrade to a paid plan

### Getting Help

If you continue experiencing issues, check:
- The Render dashboard logs
- Your Discord bot's logs
- [Lavalink documentation](https://lavalink.dev/)

## Advanced Configuration

For advanced users who want to further customize their Lavalink server:

### Custom Plugins

To add custom Lavalink plugins:

1. Uncomment the plugins section in `LavalinkServer/application.yml`
2. Add your plugin dependencies
3. Rebuild and redeploy your service

### Performance Tuning

If you upgrade to a paid Render plan, you can adjust these settings in `LavalinkServer/application.yml` for better performance:

```yaml
# Higher quality audio for paid plans with more resources
bufferDurationMs: 400
frameBufferDurationMs: 5000
opusEncodingQuality: 10
resamplingQuality: MEDIUM
```

### YouTube API Integration

For better YouTube playback support and to avoid age restrictions:

1. Get a YouTube/Google account
2. Uncomment and configure the youtubeConfig section in `application.yml`
3. Add the credentials as environment variables in Render