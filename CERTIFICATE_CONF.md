## 1. Nginx

```yaml
nginx:
  image: "nginx:latest"
  container_name: nginx
  volumes:
    - /docker/nginx/conf:/etc/nginx:ro
    - /docker/nginx/www/:/var/www:ro
    - /certs/letsencrypt:/etc/letsencrypt:ro
    - /var/run/docker.sock:/tmp/docker.sock:ro
    - /var/log:/var/log
  ports:
    - 80:80
    - 443:443
  restart: always
```

### Nginx configuration

```Nginx
server {

  listen            80;
  listen            [::]:80;
  server_name       example.com;

  location / {
    rewrite ^ https://$host$request_uri? permanent;
  }

  location ^~ /.well-known {
    root            /var/www/letsencrypt;
  }
}
```

## 2. Certbot

```bash
docker run -it --rm --name certbot \
  -v /certs/letsencrypt:/etc/letsencrypt \
  -v /var/log/letsencrypt:/var/log/letsencrypt \
  -v /docker/nginx/www/letsencrypt:/var/www/.well-known \
  quay.io/letsencrypt/letsencrypt -t certonly \
  --agree-tos --renew-by-default \
  --webroot -w /var/www \
  -d example.com
```