# FROM arm32v7/node:18-bullseye
FROM arm64v8/node:18-bullseye

# Install dependencies
RUN apt-get update && \
    apt-get install -y git ffmpeg default-mysql-client build-essential python3 nano vim gettext netcat && \
    rm -rf /var/lib/apt/lists/*

# Clone Shinobi source
RUN git clone --depth 1 https://gitlab.com/Shinobi-Systems/Shinobi.git /home/Shinobi
WORKDIR /home/Shinobi

# Copy super.json and conf.json to the Shinobi directory
COPY conf-template.json /home/Shinobi/conf-template.json
COPY super-template.json /home/Shinobi/super-template.json
COPY docker-entrypoint.sh /home/Shinobi/docker-entrypoint.sh
COPY wait-for-it.sh /home/Shinobi/wait-for-it.sh
RUN chmod +x /home/Shinobi/docker-entrypoint.sh /home/Shinobi/wait-for-it.sh

# Install Shinobi dependencies
RUN npm install --unsafe-perm

# Install pm2 globally
RUN npm install -g pm2

# Create non-root user and set permissions
RUN useradd -m shinobiuser && \
    chown -R shinobiuser:shinobiuser /home/Shinobi

# Expose Shinobi port
EXPOSE 8080

# Set up config and volumes
VOLUME ["/config", "/home/Shinobi/videos", "/var/lib/mysql"]

# Switch to non-root user
USER shinobiuser

# Set entrypoint
ENTRYPOINT ["/home/Shinobi/docker-entrypoint.sh"]