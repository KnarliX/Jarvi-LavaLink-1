# Jarvi Lavalink Server Deployment Guide

This guide will help you deploy the Lavalink server for your "Jarvi" Discord music bot on render.com's free plan.

## Prerequisites

- A render.com account
- Git repository with this Lavalink server code

## Deployment Steps

### 1. Fork or Clone This Repository

First, make sure you have your own copy of this repository on GitHub or GitLab.

### 2. Connect to Render.com

1. Sign in to your render.com account
2. Click on "New +" button
3. Select "Web Service"
4. Connect your GitHub/GitLab account and select your forked/cloned repository

### 3. Configure the Service

Fill in the following details:
- **Name**: jarvi-lavalink
- **Environment**: Docker
- **Region**: Choose the one closest to your Discord bot's server location
- **Branch**: main (or your preferred branch)
- **Plan**: Free

### 4. Set Environment Variables

Add the following environment variables:
- `SERVER_PORT`: 80
- `LAVALINK_SERVER_PASSWORD`: Jarvi1.0 (or your preferred password)
- `_JAVA_OPTIONS`: -Xmx512m

Note: You can add these later in the Render dashboard if needed.

### 5. Deploy

Click "Create Web Service" to deploy your Lavalink server.

Render will automatically detect the Dockerfile and build/deploy your service. The deployment process may take a few minutes.

### 6. Check Deployment

Once deployed, your Lavalink server will be available at: `https://jarvi-lavalink.onrender.com`

## Connecting Your Bot

Update your Discord bot's configuration to connect to your new Lavalink server:

```json
{
  "nodes": [
    {
      "host": "jarvi-lavalink.onrender.com",
      "port": 80,
      "password": "Jarvi1.0",
      "secure": true
    }
  ]
}
```

Note: Make sure to replace the password with the one you set in the environment variables if you changed it.

## Important Notes

- The free plan on render.com may have some limitations on uptime and performance.
- Your service might spin down after periods of inactivity - the first request after inactivity may take longer to respond.
- For production use with heavy traffic, consider upgrading to a paid plan.

## Troubleshooting

- **Connection Issues**: Ensure your bot is using secure WebSocket connections (wss://)
- **Invalid Password**: Double-check the password matches between your Lavalink server and bot configuration
- **Server Errors**: Check the logs in the Render dashboard for details on any issues