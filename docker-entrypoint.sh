#!/bin/sh
set -e

# Generate conf.json from template
if [ -f /home/Shinobi/conf-template.json ]; then
  envsubst < /home/Shinobi/conf-template.json > /home/Shinobi/conf.json
fi

# Generate super.json from template
if [ -f /home/Shinobi/super-template.json ]; then
  envsubst < /home/Shinobi/super-template.json > /home/Shinobi/super.json
fi

# Wait for MySQL to be ready
if [ -n "$MYSQL_HOST" ]; then
  /home/Shinobi/wait-for-it.sh "$MYSQL_HOST:3306" -- echo "MySQL is up"
fi

# Start Shinobi (use pm2 if desired, fallback to node)
if command -v pm2 >/dev/null 2>&1; then
  exec pm2-runtime camera.js
else
  exec node camera.js
fi
