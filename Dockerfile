FROM fredboat/lavalink:legacy

# Setup working directory
WORKDIR /opt/Lavalink

# Create simple status page
RUN echo '<!DOCTYPE html><html><head><title>Jarvi Lavalink</title><style>body{font-family:Arial,sans-serif;display:flex;justify-content:center;align-items:center;height:100vh;margin:0;background:#f7f7f7}.container{text-align:center;padding:2em;border-radius:8px;background:white;box-shadow:0 4px 8px rgba(0,0,0,0.1);max-width:80%}.status{color:#4CAF50;font-weight:bold;margin:1em 0}.info{margin-top:2em;color:#555}.footer{margin-top:2em;font-size:0.8em;color:#777}</style></head><body><div class="container"><h1>Jarvi Lavalink Server</h1><div class="status">✅ Server Status: ONLINE</div><div class="info"><p>This is a premium audio server for the Jarvi Discord music bot.</p><p>Audio Quality: 10/10</p></div><div class="footer">Jarvi Lavalink Server © 2025</div></div></body></html>' > /var/www/html/index.html

# Modify application.yml for premium audio quality
RUN sed -i 's/youtubePlaylistLoadLimit:.*/youtubePlaylistLoadLimit: 10/' application.yml && \
    sed -i 's/server:/server:\n  http2:\n    enabled: false/' application.yml && \
    sed -i 's/password:.*/password: "Jarvi1.0"/' application.yml && \
    sed -i 's/frameBufferDurationMs:.*/frameBufferDurationMs: 4000/' application.yml && \
    sed -i 's/bufferDurationMs:.*/bufferDurationMs: 400/' application.yml && \
    sed -i 's/opusEncodingQuality:.*/opusEncodingQuality: 10/' application.yml && \
    sed -i 's/resamplingQuality:.*/resamplingQuality: HIGH/' application.yml 

# Create startup script
RUN echo '#!/bin/bash' > /opt/Lavalink/start.sh && \
    echo 'echo "Starting Jarvi Lavalink Server"' >> /opt/Lavalink/start.sh && \
    echo 'if [ -n "$PORT" ]; then' >> /opt/Lavalink/start.sh && \
    echo '    sed -i "s/BIND_PORT=.*/BIND_PORT=$PORT/" /opt/Lavalink/application.properties' >> /opt/Lavalink/start.sh && \
    echo 'fi' >> /opt/Lavalink/start.sh && \
    echo 'cd /opt/Lavalink' >> /opt/Lavalink/start.sh && \
    echo 'nginx &' >> /opt/Lavalink/start.sh && \
    echo 'java -Djdk.tls.client.protocols=TLSv1.1,TLSv1.2 -Xmx512m -jar Lavalink.jar' >> /opt/Lavalink/start.sh && \
    chmod +x /opt/Lavalink/start.sh

# Make sure Nginx uses our status page as default
RUN echo 'server { listen 80; root /var/www/html; index index.html; location / { try_files $uri $uri/ =404; } }' > /etc/nginx/http.d/default.conf

# Start command
CMD ["/opt/Lavalink/start.sh"]