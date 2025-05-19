FROM openjdk:13-alpine

# Install required packages
RUN apk add --no-cache bash curl busybox

# Create app directory
WORKDIR /app

# Download Lavalink JAR
RUN curl -L https://github.com/lavalink-devs/Lavalink/releases/download/3.7.8/Lavalink.jar -o Lavalink.jar

# Write Lavalink config
RUN echo 'server:' > application.yml && \
    echo '  port: ${PORT:2333}' >> application.yml && \
    echo '  address: 0.0.0.0' >> application.yml && \
    echo 'lavalink:' >> application.yml && \
    echo '  server:' >> application.yml && \
    echo '    password: "Janvijaanu"' >> application.yml && \
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

# Make web directory and copy index.html
RUN mkdir -p /www
COPY index.html /www/index.html

# Expose Lavalink port and web status port
EXPOSE 2333 8080

# Start script for Lavalink + static page server
RUN echo '#!/bin/sh' > start.sh && \
    echo 'echo "Starting Lavalink and static status server..."' >> start.sh && \
    echo 'busybox httpd -f -p 8080 -h /www &' >> start.sh && \
    echo 'java -Xmx400m -jar Lavalink.jar' >> start.sh && \
    chmod +x start.sh

# Start both Lavalink and static site
CMD ["./start.sh"]
