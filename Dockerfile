FROM caddy:2-builder as builder

# https://github.com/caddy-dns, cloudflare,gandi,alidns
RUN xcaddy build master \
  --with github.com/caddy-dns/cloudflare@latest \
  --with github.com/caddy-dns/gandi@latest \
  --with github.com/caddy-dns/alidns@latest \
  --with github.com/kairyou/caddy-dns-dnspod@ff9bf81

# install caddy
FROM caddy:2-alpine

RUN apk add --no-cache \
  tzdata \
  curl

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# validate install
# RUN caddy list-modules
RUN caddy version
RUN caddy environ

# EXPOSE 80 443 2019
WORKDIR /srv

RUN echo "" > /srv/index.html

# ENTRYPOINT ["caddy"]
# CMD ["run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
