FROM eclipse-temurin:18-jdk-jammy

WORKDIR /opt/Lavalink

# Copy source code
COPY LavalinkServer/ .

# Build the project
RUN ./gradlew build --no-daemon

# Switch to non-root user after build (optional)
RUN groupadd -g 322 lavalink && useradd -r -u 322 -g lavalink lavalink && chown -R lavalink:lavalink /opt/Lavalink
USER lavalink

ENTRYPOINT ["java", "-Djdk.tls.client.protocols=TLSv1.1,TLSv1.2", "-jar", "build/libs/Lavalink.jar"]
