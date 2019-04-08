# c9-base

Docker image for Cloud9 SDK

## Example

- Host: c9host
- User: c9user (UID 1000)
- Password: c9user
- Group: c9 (GID 1000)
- Home: /home/c9user
- Port: 8181

```sh
docker run --rm -it \
  -h c9host \
  -p 8181:8181 \
  -v /path/to/yourhome:/home/c9user \
  -e C9USER=c9user \
  -e C9UID=1000 \
  -e C9PASSWORD=c9user \
  -e C9HOME=/home/c9user \
  -e C9GROUP=c9user \
  -e C9GID=1000 \
  -t okamumu/c9-base
```
