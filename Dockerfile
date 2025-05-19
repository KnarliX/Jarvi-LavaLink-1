FROM adoptopenjdk/openjdk11:alpine-jre

# Install minimal required packages
RUN apk add --no-cache bash curl netcat-openbsd

# Create app directory
WORKDIR /app

# Download Lavalink.jar (fixed version for stability)
RUN curl -L https://github.com/freyacodes/Lavalink/releases/download/3.7.8/Lavalink.jar -o Lavalink.jar

# Create plugins directory and download essential plugin
RUN mkdir -p plugins && \
    # Only LavaSrc plugin for premium quality without bloat
    curl -L https://github.com/topi314/LavaSrc/releases/download/4.0.0/lavasrc-plugin-4.0.0.jar -o plugins/lavasrc-plugin.jar

# Create a lightweight application.yml with premium quality
RUN echo "server:" > application.yml && \
    echo "  port: \${SERVER_PORT:80}" >> application.yml && \
    echo "  address: 0.0.0.0" >> application.yml && \
    echo "lavalink:" >> application.yml && \
    echo "  server:" >> application.yml && \
    echo "    password: \${LAVALINK_SERVER_PASSWORD:Jarvi1.0}" >> application.yml && \
    echo "    sources:" >> application.yml && \
    echo "      youtube: true" >> application.yml && \
    echo "      soundcloud: true" >> application.yml && \
    echo "      bandcamp: true" >> application.yml && \
    echo "      twitch: true" >> application.yml && \
    echo "    bufferDurationMs: 400" >> application.yml && \
    echo "    frameBufferDurationMs: 3000" >> application.yml && \
    echo "    opusEncodingQuality: 10" >> application.yml && \
    echo "    resamplingQuality: HIGH" >> application.yml && \
    echo "    trackStuckThresholdMs: 10000" >> application.yml && \
    echo "    youtubeSearchEnabled: true" >> application.yml && \
    echo "    soundcloudSearchEnabled: true" >> application.yml && \
    echo "plugins:" >> application.yml && \
    echo "  lavasrc:" >> application.yml && \
    echo "    providers:" >> application.yml && \
    echo "      - \"ytsearch\"" >> application.yml && \
    echo "      - \"ytmsearch\"" >> application.yml && \
    echo "      - \"scsearch\"" >> application.yml && \
    echo "    sources:" >> application.yml && \
    echo "      spotify: true" >> application.yml && \
    echo "      youtube: true" >> application.yml

# Create logs directory
RUN mkdir -p logs

# Create a very simple health check page
RUN echo '<!DOCTYPE html><html><head><title>Jarvi Lavalink</title></head><body><h1>Jarvi Lavalink Server</h1><p>Status: Online</p><p>Premium audio quality for Jarvi Discord bot</p></body></html>' > index.html

# Create optimized start script
RUN echo '#!/bin/bash' > start.sh && \
    echo '' >> start.sh && \
    echo '# Set lightweight memory settings' >> start.sh && \
    echo 'export _JAVA_OPTIONS="-Xmx450m -Xms100m -XX:+UseG1GC"' >> start.sh && \
    echo '' >> start.sh && \
    echo '# Handle render.com PORT environment variable' >> start.sh && \
    echo 'if [ -n "$PORT" ]; then' >> start.sh && \
    echo '    export SERVER_PORT=$PORT' >> start.sh && \
    echo 'fi' >> start.sh && \
    echo '' >> start.sh && \
    echo '# Create simple health check endpoint for UptimeRobot' >> start.sh && \
    echo 'while true; do { echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n$(cat index.html)"; } | nc -l -p 8080 > /dev/null 2>&1; done &' >> start.sh && \
    echo '' >> start.sh && \
    echo '# Start Lavalink with premium quality' >> start.sh && \
    echo 'echo "Starting Jarvi Lavalink server..."' >> start.sh && \
    echo 'java -jar Lavalink.jar' >> start.sh && \
    chmod +x start.sh

# Expose ports
EXPOSE 80 8080

# Start command
CMD ["/bin/bash", "./start.sh"]