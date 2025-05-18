#!/bin/bash

# Set memory constraints for render.com free tier
export _JAVA_OPTIONS="-Xmx512m -Xms128m ${_JAVA_OPTIONS}"

# Set port handling for render.com
if [ -n "$PORT" ]; then
    export SERVER_PORT=$PORT
fi

echo "Starting Jarvi Lavalink server..."
echo "Using port: ${SERVER_PORT:-80}"
echo "Using memory settings: ${_JAVA_OPTIONS}"

# Start Lavalink
java -Djdk.tls.client.protocols=TLSv1.1,TLSv1.2 -jar Lavalink.jar