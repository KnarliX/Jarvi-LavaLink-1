# Jarvi Lavalink Server

A Lavalink server configured for easy one-click deployment on render.com's free plan for the "Jarvi" Discord music bot.

## About This Project

This repository contains a customized Lavalink server setup specifically optimized for:
- One-click deployment on render.com's free plan
- Integration with the "Jarvi" Discord music bot
- Minimal resource usage while maintaining good audio quality

## Features

- Pre-configured for optimal performance on render.com
- Memory usage optimized for free tier limitations
- Automatic port configuration
- Health checks for maximum uptime
- Persistent plugin storage

## Quick Deployment

1. Click the button below to deploy to render.com:

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

2. Follow the on-screen instructions:
   - Connect your GitHub account
   - Select this repository
   - Configure environment variables if needed

## Manual Deployment

See the detailed [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) for step-by-step instructions.

## Connecting Your Jarvi Bot

Once deployed, you can connect your Jarvi Discord bot using these connection details:

```json
{
  "nodes": [
    {
      "host": "your-app-name.onrender.com",
      "port": 80,
      "password": "Jarvi1.0",
      "secure": true
    }
  ]
}
```

## Environment Variables

You can customize your Lavalink server by setting these environment variables in the render.com dashboard:

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVER_PORT` | Port to run the server on | 80 |
| `LAVALINK_SERVER_PASSWORD` | Password for Lavalink authentication | Jarvi1.0 |
| `_JAVA_OPTIONS` | Java runtime options | -Xmx512m -Xms128m |

## Notes for Production Use

- The free plan on render.com has limited resources and may experience downtime after periods of inactivity
- For production use with many users, consider upgrading to a paid plan
- You can customize the `application.yml` file for additional configuration options

## Troubleshooting

If you encounter issues:

1. Check the logs in your render.com dashboard
2. Verify your bot is using the correct connection details
3. Ensure your bot is using secure WebSocket connections (wss://)
4. Check if the Lavalink server is running by visiting `https://your-app-name.onrender.com/version`

## Resources

- [Lavalink Documentation](https://lavalink.dev/)
- [Render.com Documentation](https://docs.render.com/)
- [Jarvi Bot Documentation](https://jarvi-bot.com/) (replace with your actual docs)