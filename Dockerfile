FROM eclipse-temurin:17-jre-alpine

# Install necessary packages
RUN apk add --no-cache bash curl nodejs npm

# Create app directory
WORKDIR /app

# Download Lavalink.jar
RUN curl -L https://github.com/lavalink-devs/Lavalink/releases/latest/download/Lavalink.jar -o Lavalink.jar

# Download LavaSrc plugin for premium music quality
RUN mkdir -p plugins && \
    curl -L https://github.com/topi314/LavaSrc/releases/latest/download/lavasrc-plugin.jar -o plugins/lavasrc-plugin.jar

# Create the application.yml file with premium quality settings
RUN echo "server:" > application.yml && \
    echo "  port: \${SERVER_PORT:80}" >> application.yml && \
    echo "  address: 0.0.0.0" >> application.yml && \
    echo "  http2:" >> application.yml && \
    echo "    enabled: true" >> application.yml && \
    echo "lavalink:" >> application.yml && \
    echo "  server:" >> application.yml && \
    echo "    password: \${LAVALINK_SERVER_PASSWORD:Jarvi1.0}" >> application.yml && \
    echo "    sources:" >> application.yml && \
    echo "      youtube: true" >> application.yml && \
    echo "      bandcamp: true" >> application.yml && \
    echo "      soundcloud: true" >> application.yml && \
    echo "      twitch: true" >> application.yml && \
    echo "      vimeo: true" >> application.yml && \
    echo "      nico: true" >> application.yml && \
    echo "      http: true" >> application.yml && \
    echo "      local: true" >> application.yml && \
    echo "    bufferDurationMs: 400" >> application.yml && \
    echo "    frameBufferDurationMs: 5000" >> application.yml && \
    echo "    opusEncodingQuality: 10" >> application.yml && \
    echo "    resamplingQuality: HIGH" >> application.yml && \
    echo "    trackStuckThresholdMs: 10000" >> application.yml && \
    echo "    useSeekGhosting: true" >> application.yml && \
    echo "    youtubePlaylistLoadLimit: 10" >> application.yml && \
    echo "    playerUpdateInterval: 2" >> application.yml && \
    echo "    youtubeSearchEnabled: true" >> application.yml && \
    echo "    soundcloudSearchEnabled: true" >> application.yml && \
    echo "    gc-warnings: true" >> application.yml && \
    echo "    filters:" >> application.yml && \
    echo "      volume: true" >> application.yml && \
    echo "      equalizer: true" >> application.yml && \
    echo "      karaoke: true" >> application.yml && \
    echo "      timescale: true" >> application.yml && \
    echo "      tremolo: true" >> application.yml && \
    echo "      vibrato: true" >> application.yml && \
    echo "      distortion: true" >> application.yml && \
    echo "      rotation: true" >> application.yml && \
    echo "      channelMix: true" >> application.yml && \
    echo "      lowPass: true" >> application.yml && \
    echo "plugins:" >> application.yml && \
    echo "  lavasrc:" >> application.yml && \
    echo "    providers:" >> application.yml && \
    echo "      - \"ytsearch\"" >> application.yml && \
    echo "      - \"ytmsearch\"" >> application.yml && \
    echo "      - \"scsearch\"" >> application.yml

# Create directories
RUN mkdir -p logs plugins

# Copy health check server
COPY health.js health.js

# Create start script with health check
RUN echo '#!/bin/bash' > start.sh && \
    echo 'export _JAVA_OPTIONS="-Xmx512m -Xms128m ${_JAVA_OPTIONS}"' >> start.sh && \
    echo 'if [ -n "$PORT" ]; then export SERVER_PORT=$PORT; fi' >> start.sh && \
    echo 'echo "Starting Jarvi Lavalink server on port ${SERVER_PORT:-80}"' >> start.sh && \
    echo '# Start health check server in background' >> start.sh && \
    echo 'node health.js &' >> start.sh && \
    echo '# Start Lavalink' >> start.sh && \
    echo 'java -Djdk.tls.client.protocols=TLSv1.1,TLSv1.2 -jar Lavalink.jar' >> start.sh && \
    chmod +x start.sh

# Create server status script for robot monitoring
RUN echo '<!DOCTYPE html><html><head><title>Jarvi Lavalink Server</title></head><body><h1>Jarvi Lavalink Server</h1><p>Status: Online</p><p>For Discord bot "Jarvi"</p></body></html>' > status.html

# Expose server port and health check port
EXPOSE 80 8080

# Start command
CMD ["/bin/bash", "./start.sh"]