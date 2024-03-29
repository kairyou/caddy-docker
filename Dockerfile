# 2-builder-alpine
FROM caddy:2-builder as builder

# github.com/caddy-dns, cloudflare,gandi,alidns
RUN xcaddy build master \
  --with github.com/caddy-dns/dnspod \
  # --with github.com/kairyou/caddy-dns-dnspod@latest \
  --with github.com/caddy-dns/alidns \
  --with github.com/caddy-dns/gandi \
  --with github.com/caddy-dns/cloudflare

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
