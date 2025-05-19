FROM openjdk:13-alpine

# Install minimal packages
RUN apk add --no-cache bash curl

# Create app directory
WORKDIR /app

# Download Lavalink.jar (latest stable version)
RUN curl -L https://github.com/lavalink-devs/Lavalink/releases/download/3.7.8/Lavalink.jar -o Lavalink.jar

# Create a simple application.yml optimized for render.com
RUN echo 'server:' > application.yml && \
    echo '  port: ${PORT:2333}' >> application.yml && \
    echo '  address: 0.0.0.0' >> application.yml && \
    echo 'lavalink:' >> application.yml && \
    echo '  server:' >> application.yml && \
    echo '    password: "Jarvi1.0"' >> application.yml && \
    echo '    sources:' >> application.yml && \
    echo '      youtube: true' >> application.yml && \
    echo '      soundcloud: true' >> application.yml && \
    echo '    youtubeSearchEnabled: true' >> application.yml && \
    echo '    soundcloudSearchEnabled: true' >> application.yml && \
    echo '    bufferDurationMs: 400' >> application.yml && \
    echo '    youtubePlaylistLoadLimit: 5' >> application.yml && \
    echo '    opusEncodingQuality: 10' >> application.yml && \
    echo 'logging:' >> application.yml && \
    echo '  file:' >> application.yml && \
    echo '    max-history: 1' >> application.yml && \
    echo '    max-size: 10MB' >> application.yml && \
    echo '  level:' >> application.yml && \
    echo '    root: INFO' >> application.yml && \
    echo '    lavalink: INFO' >> application.yml

# Create status page for health checks
RUN echo '<html><head><title>Jarvi Lavalink</title></head><body><h1>Jarvi Music Server</h1><p>Status: Online</p></body></html>' > index.html

# Create logs directory
RUN mkdir -p logs

# Create startup script
RUN echo '#!/bin/sh' > start.sh && \
    echo 'echo "Starting Jarvi Lavalink server on port ${PORT:-2333}"' >> start.sh && \
    echo 'java -Xmx400m -jar Lavalink.jar' >> start.sh && \
    chmod +x start.sh

# Expose port
EXPOSE 2333

# Start command
CMD ["./start.sh"]