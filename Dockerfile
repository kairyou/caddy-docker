FROM caddy:2-builder as builder

# https://github.com/caddy-dns, godaddy,alidns
RUN xcaddy build master \
  --with github.com/caddy-dns/cloudflare@latest \
  --with github.com/caddy-dns/gandi@latest \
  --with github.com/caddy-dns/dnspod@a77ccca0b0b4b4b993073ce0b3b26117daf14cf3

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
