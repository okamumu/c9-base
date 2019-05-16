# c9-base

Docker image for Cloud9 SDK. In this image, the process of Cloud9 can be monitored by pm2 and pm2-gui.

## Example

- PM2GUI
  - Port: 80
  - Password: pm2
- Cloud9
  - Host: c9host
  - User: c9user (UID 1000)
  - Password: c9user
  - Group: c9 (GID 1000)
  - Home: /home/c9user
  - Port: 8181

```sh
docker run --rm -it \
  -h c9host \
  -p 80:80 \
  -p 8181:8181 \
  -e PM2PORT=80 \
  -e PM2PASSWORD=pm2 \
  -e C9USER=c9user \
  -e C9UID=1000 \
  -e C9PASSWORD=c9user \
  -e C9HOME=/home/c9user \
  -e C9GROUP=c9user \
  -e C9GID=1000 \
  -e C9PORT=8181 \
  -t okamumu/c9-base
```
