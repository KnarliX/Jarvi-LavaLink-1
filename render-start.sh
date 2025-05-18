#!/bin/bash

# This script is used by render.com to start the application
# It handles the environment variable PORT that render.com sets

# Set the port based on render.com's PORT environment variable if available
if [ -n "$PORT" ]; then
    echo "Render.com PORT detected: $PORT"
    export SERVER_PORT=$PORT
fi

# Print configuration information
echo "=== JARVI LAVALINK SERVER ==="
echo "Starting server with the following configuration:"
echo "Server Port: ${SERVER_PORT:-80}"
echo "Java Options: ${_JAVA_OPTIONS}"
echo "==============================="

# Start the main script
./start.sh