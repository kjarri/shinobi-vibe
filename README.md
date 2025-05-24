# Cloudflare Tunnel + Nginx + Shinobi Docker Compose Example

This vibe-coded project demonstrates how to run two applications using Docker Compose:

1. **Web App**: A simple Nginx server that serves a static HTML page. This is used to verify that your Cloudflare Tunnel and local networking are working correctly.
2. **Shinobi NVR**: A powerful open-source Network Video Recorder (NVR) for video surveillance, running in its own container.

Both applications can be securely exposed to the internet using [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/), without opening any ports on your firewall.

## Overview
- **Nginx** serves a static HTML page (`index.html`) locally for connectivity testing.
- **Shinobi** provides a full-featured NVR for video surveillance.
- **Cloudflared** (Cloudflare Tunnel) securely exposes your services to the public internet.
- All services are orchestrated using Docker Compose for easy setup and management.

## Files
- `docker-compose.yml`: Defines the Nginx, Shinobi, and Cloudflared services and their network.
- `Dockerfile`: Builds the Shinobi container with all required dependencies.
- `index.html`: The static web page served by Nginx.
- `super.json`, `conf.json`: Shinobi configuration files.
- `.env`: Stores all required environment variables and secrets (do **not** share this file).

## Prerequisites
- [Docker](https://www.docker.com/get-started) installed on your machine.
- A Cloudflare account and a configured Tunnel token. [See Cloudflare docs](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/create-tunnel/) for how to create a tunnel and get your token.

## Environment Variables
Create a `.env` file in the project root with the following variables:

```env
# Cloudflare Tunnel tokens
TUNNEL_TOKEN=your_cloudflare_tunnel_token_here         # For the main tunnel (web app)
TUNNEL_TOKEN_NGINX=your_cloudflare_tunnel_token_nginx_here # (Optional) For a separate Nginx tunnel

# Shinobi MySQL database configuration
MYSQL_ROOT_PASSWORD=your_mysql_root_password
MYSQL_DATABASE=shinobi
MYSQL_USER=justjoia
MYSQL_PASSWORD=your_mysql_password

# Shinobi admin password hash
ADMIN_PASSWORD_HASH=your_admin_password_hash
```

- `TUNNEL_TOKEN` is required for Cloudflared to authenticate and create a tunnel.
- `TUNNEL_TOKEN_NGINX` is optional if you want a separate tunnel for Nginx.
- The Shinobi variables are required for the Shinobi NVR service to connect to its database and set up the admin user.

## Usage
1. **Add your environment variables**
   - Copy the example above into a `.env` file and fill in your values.
2. **Start the services**
   - Run:
     ```sh
     docker-compose up -d
     ```
3. **Access your applications**
   - **Web App**: Visit the public URL provided by Cloudflare Tunnel in your Cloudflare dashboard, or access locally at [http://localhost:8088](http://localhost:8088).
   - **Shinobi**: Access the Shinobi web interface at the public tunnel URL (see your Cloudflare dashboard) or locally at [http://localhost:8080](http://localhost:8080).

## Stopping the Services
To stop and remove the containers, run:
```sh
  docker-compose down
```

## Running on a Fresh Raspberry Pi

Follow these steps to set up and run this project on a new Raspberry Pi (tested on Raspberry Pi OS):

### 1. Update your system
```sh
sudo apt update && sudo apt upgrade -y
```

### 2. Install Docker
```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
Add your user to the `docker` group (optional, for running Docker without `sudo`):
```sh
sudo usermod -aG docker $USER
# Log out and back in for group changes to take effect
```

### 3. Install Docker Compose
```sh
sudo apt-get install -y libffi-dev libssl-dev python3 python3-pip
sudo pip3 install docker-compose
```

### 4. Clone this repository and enter the directory
```sh
git clone <your-repo-url>
cd shinobi-vibe
```

### 5. Create the `.env` file
Copy the example from the README and fill in your values:
```sh
nano .env
```

### 6. Start the services
```sh
docker-compose up -d
```

### 7. Access your applications
- **Web App**: http://localhost:8088 or the Cloudflare Tunnel public URL
- **Shinobi**: http://localhost:8080 or the Cloudflare Tunnel public URL

### 8. Video Storage
All video files will be saved in the `shinobi-videos` directory in your project folder on the Raspberry Pi. You can access them directly from the host.

## Security Note
- **Never share your Tunnel token or commit it to public repositories.**
- The `.env` file is used to keep your tokens and credentials private and out of version control.

---

**Happy tunneling and surveillance!**
