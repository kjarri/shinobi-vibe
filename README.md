# Cloudflare Tunnel + Nginx Docker Compose Example

This project demonstrates how to expose a local Nginx web server to the internet securely using [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/).

## Overview
- **Nginx** serves a static HTML page (`index.html`) locally.
- **Cloudflared** (Cloudflare Tunnel) securely exposes the Nginx server to the public internet without opening any ports on your firewall.
- Both services are orchestrated using Docker Compose for easy setup and management.

## Files
- `docker-compose.yml`: Defines the Nginx and Cloudflared services and their network.
- `index.html`: The static web page served by Nginx.
- `.env`: Stores your Cloudflare Tunnel token (do **not** share this token publicly).

## Prerequisites
- [Docker](https://www.docker.com/get-started) installed on your machine.
- A Cloudflare account and a configured Tunnel token. [See Cloudflare docs](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/create-tunnel/) for how to create a tunnel and get your token.

## Usage
1. **Add your Tunnel token**
   - Copy your Cloudflare Tunnel token into a `.env` file in the project root:
     ```env
     TUNNEL_TOKEN=your_cloudflare_tunnel_token_here
     ```
2. **Start the services**
   - Run:
     ```sh
     docker-compose up -d
     ```
3. **Access your site**
   - Visit the public URL provided by Cloudflare Tunnel in your Cloudflare dashboard. You can also access the site locally at [http://localhost:8088](http://localhost:8088).

## How it Works
- Nginx serves `index.html` on port 80 inside the container (mapped to 8088 on your host).
- Cloudflared runs in a separate container, authenticates with Cloudflare using your token, and creates a secure tunnel to your Nginx service.

## Stopping the Services
To stop and remove the containers, run:
```sh
docker-compose down
```

## Security Note
- **Never share your Tunnel token or commit it to public repositories.**
- The `.env` file is used to keep your token private and out of version control.

---

**Happy tunneling!**
