FROM eclipse-temurin:17-jre-alpine

# Install necessary packages
RUN apk add --no-cache bash curl nginx

# Create app directory
WORKDIR /app

# Download Lavalink.jar (latest version)
RUN curl -L https://github.com/lavalink-devs/Lavalink/releases/latest/download/Lavalink.jar -o Lavalink.jar

# Create plugins directory and download premium audio plugins
RUN mkdir -p plugins && \
    # LavaSrc plugin for premium music quality
    curl -L https://github.com/topi314/LavaSrc/releases/latest/download/lavasrc-plugin.jar -o plugins/lavasrc-plugin.jar && \
    # DuncteBot plugin for even better SoundCloud support
    curl -L https://github.com/DuncteBot/skybot-lavalink-plugin/releases/latest/download/skybot-lavalink-plugin.jar -o plugins/skybot-lavalink-plugin.jar && \
    # Volume Normalization plugin
    curl -L https://github.com/esmBot/lava-xm-plugin/releases/latest/download/lava-xm-plugin.jar -o plugins/lava-xm-plugin.jar

# Create the application.yml file with premium quality settings
RUN echo "server:" > application.yml && \
    echo "  port: \${SERVER_PORT:2333}" >> application.yml && \
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
    echo "    bufferDurationMs: 500" >> application.yml && \
    echo "    frameBufferDurationMs: 5000" >> application.yml && \
    echo "    opusEncodingQuality: 10" >> application.yml && \
    echo "    resamplingQuality: HIGH" >> application.yml && \
    echo "    trackStuckThresholdMs: 10000" >> application.yml && \
    echo "    useSeekGhosting: true" >> application.yml && \
    echo "    youtubePlaylistLoadLimit: 15" >> application.yml && \
    echo "    playerUpdateInterval: 1" >> application.yml && \
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
    echo "      - \"scsearch\"" >> application.yml && \
    echo "    sources:" >> application.yml && \
    echo "      spotify: true" >> application.yml && \
    echo "      applemusic: true" >> application.yml && \
    echo "      deezer: true" >> application.yml && \
    echo "      yandexmusic: true" >> application.yml && \
    echo "  dunctebot:" >> application.yml && \
    echo "    ttsLanguage: en-US" >> application.yml && \
    echo "    sources:" >> application.yml && \
    echo "      getyarn: true" >> application.yml && \
    echo "      clypit: true" >> application.yml && \
    echo "      tts: true" >> application.yml

# Create logs directory
RUN mkdir -p logs

# Create status page for UptimeRobot monitoring
RUN mkdir -p /var/www/html && \
    echo '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Jarvi Lavalink Server - Status</title><style>body{font-family:Arial,sans-serif;line-height:1.6;margin:0;padding:20px;background-color:#f5f5f5;color:#333}.container{max-width:800px;margin:0 auto;background-color:#fff;padding:20px;border-radius:5px;box-shadow:0 0 10px rgba(0,0,0,0.1)}h1{color:#4a6ee0;border-bottom:2px solid #eee;padding-bottom:10px}.status{padding:15px;margin:15px 0;border-radius:4px}.online{background-color:#d4edda;color:#155724;border:1px solid #c3e6cb}.info{background-color:#f8f9fa;padding:15px;border-left:4px solid #4a6ee0;margin:20px 0}.footer{margin-top:30px;text-align:center;font-size:0.9em;color:#777}</style></head><body><div class="container"><h1>Jarvi Lavalink Server</h1><div class="status online"><h2>✅ Server Status: ONLINE</h2><p>The Lavalink server is currently operational.</p></div><div class="info"><h3>Server Information</h3><ul><li><strong>Server Type:</strong> Lavalink (Audio Streaming)</li><li><strong>Bot Integration:</strong> Jarvi Discord Music Bot</li><li><strong>Audio Quality:</strong> Premium (10/10)</li><li><strong>Hosting:</strong> Render.com</li></ul></div><div class="info"><h3>Premium Features</h3><ul><li>Maximum audio quality (Opus 10/10)</li><li>Spotify, Apple Music, YouTube, SoundCloud integration</li><li>Advanced audio filters and equalizer</li><li>Volume normalization</li><li>Low latency streaming</li></ul></div><div class="footer"><p>Jarvi Lavalink Server © 2025 | Designed for premium music experience</p></div></div></body></html>' > /var/www/html/index.html

# Create Nginx configuration for status page and proxying
RUN echo 'server {\n    listen 80;\n    server_name localhost;\n\n    # Serve status page\n    location / {\n        root /var/www/html;\n        index index.html;\n    }\n\n    # Health check endpoint for UptimeRobot\n    location /health {\n        return 200 "OK";\n        add_header Content-Type text/plain;\n    }\n\n    # WebSocket proxy for Lavalink\n    location ~ ^/(v4|v[0-9]+|ws|websocket) {\n        proxy_pass http://localhost:2333;\n        proxy_http_version 1.1;\n        proxy_set_header Upgrade $http_upgrade;\n        proxy_set_header Connection "upgrade";\n        proxy_set_header Host $host;\n        proxy_set_header X-Real-IP $remote_addr;\n        proxy_read_timeout 60s;\n        proxy_send_timeout 60s;\n    }\n\n    # HTTP API proxy for Lavalink\n    location /lavalink {\n        proxy_pass http://localhost:2333;\n        proxy_http_version 1.1;\n        proxy_set_header Host $host;\n        proxy_set_header X-Real-IP $remote_addr;\n    }\n}' > /etc/nginx/http.d/default.conf

# Create optimized start script
RUN echo '#!/bin/bash\n\n# Set premium audio quality memory settings\nexport _JAVA_OPTIONS="-Xmx512m -Xms128m -XX:+UseG1GC -XX:MaxGCPauseMillis=100 ${_JAVA_OPTIONS}"\n\n# Handle render.com PORT environment variable\nif [ -n "$PORT" ]; then\n    # Update Nginx configuration to listen on the PORT assigned by render.com\n    sed -i "s/listen 80;/listen $PORT;/" /etc/nginx/http.d/default.conf\nfi\n\n# Start Nginx in background\necho "Starting Nginx for premium status page and monitoring..."\nnginx &\n\n# Start Lavalink with premium settings\necho "Starting Jarvi Lavalink server with PREMIUM AUDIO QUALITY..."\njava -Djdk.tls.client.protocols=TLSv1.1,TLSv1.2 -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -jar Lavalink.jar' > start.sh && \
    chmod +x start.sh

# Expose ports
EXPOSE 80 2333

# Start command
CMD ["/bin/bash", "./start.sh"]