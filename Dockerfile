# 2-builder-alpine
FROM caddy:2.11.7-builder-alpine AS builder

# github.com/caddy-dns, cloudflare,gandi,alidns
RUN xcaddy build v2.11.7 \
  --with github.com/caddy-dns/dnspod@fb7cc31cc04c68a304b8d2672c3e5d9f2ad3d7ba \
  # --with github.com/kairyou/caddy-dns-dnspod@latest \
  --with github.com/caddy-dns/alidns@v1.0.29 \
  --with github.com/caddy-dns/gandi@v1.2.1 \
  --with github.com/caddy-dns/cloudflare@v0.2.4

# install caddy
FROM caddy:2.11.7-alpine

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
