FROM azul/zulu-openjdk-alpine:17-jre-headless-latest

# Install necessary packages
RUN apk add --no-cache libgcc curl bash

# Create directory structure
WORKDIR /opt/Lavalink

# Download the latest Lavalink.jar
RUN curl -L https://github.com/lavalink-devs/Lavalink/releases/latest/download/Lavalink.jar -o Lavalink.jar

# Copy configuration and startup scripts
COPY LavalinkServer/application.yml application.yml
COPY start.sh start.sh
COPY render-start.sh render-start.sh
RUN chmod +x start.sh render-start.sh

# Create plugins directory
RUN mkdir -p plugins
RUN mkdir -p logs

# Create a user to run Lavalink
RUN addgroup -g 322 -S lavalink && \
    adduser -u 322 -S lavalink -G lavalink && \
    chown -R lavalink:lavalink /opt/Lavalink

# Add health check script
RUN echo '#!/bin/sh\ncurl -f http://localhost:${SERVER_PORT:-80}/version || exit 1' > /healthcheck.sh && \
    chmod +x /healthcheck.sh

# Set up the health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 CMD /healthcheck.sh

# Set environment variables
ENV SERVER_PORT=80

# Expose the server port
EXPOSE ${SERVER_PORT:-80}

# Switch to the lavalink user
USER lavalink

# Run Lavalink with appropriate memory settings for render.com free tier
CMD ["./render-start.sh"]