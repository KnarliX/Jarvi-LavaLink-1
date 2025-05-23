# Jarvi Lavalink Server

<img align="right" src="/branding/lavalink.svg" width=200 alt="Lavalink logo">

A Lavalink server configured for easy one-click deployment on render.com's free plan for the "Jarvi" Discord music bot.

## Quick Deployment

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

## Features

- Optimized for render.com's free plan
- Ready for use with Jarvi Discord music bot
- Pre-configured for optimal performance
- Memory optimizations to work within free tier constraints
- Easy one-click deployment

## Setup Instructions

1. Fork this repository to your GitHub account
2. Click the "Deploy to Render" button above
3. Connect your Render account if prompted
4. Render will automatically configure and deploy the Lavalink server
5. Once deployed, your Lavalink server will be available at:
   `https://jarvi-lavalink.onrender.com`

## Connecting Your Bot

Update your Jarvi Discord bot configuration to connect to this Lavalink server:

```json
{
  "nodes": [
    {
      "host": "jarvi-lavalink.onrender.com",
      "port": 443,
      "password": "Jarvi1.0",
      "secure": true
    }
  ]
}
```

## Configuration

The Lavalink server comes pre-configured for optimal performance on render.com's free plan.

You can customize the server by modifying these environment variables in the Render dashboard:

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVER_PORT` | Port to run the server on | 80 |
| `LAVALINK_SERVER_PASSWORD` | Password for Lavalink authentication | Jarvi1.0 |
| `_JAVA_OPTIONS` | Java runtime options | -Xmx512m -Xms128m |

## Detailed Documentation

For more detailed instructions and advanced configuration options, please see:

- [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) - Basic deployment instructions
- [COMPREHENSIVE_GUIDE.md](./COMPREHENSIVE_GUIDE.md) - Detailed setup and configuration options

## Lavalink Features

* Powered by Lavaplayer
* Minimal CPU/memory footprint
* Twitch/YouTube stream support
* Event system
* Seeking
* Volume control
* REST API for resolving tracks and controlling players
* Statistics (good for load balancing)
* Basic authentication
* Plugin support

## Credits

This project is based on [Lavalink](https://github.com/lavalink-devs/Lavalink), optimized specifically for the Jarvi Discord music bot on render.com's free plan.

