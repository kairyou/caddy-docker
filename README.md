# caddy-docker
Caddy v2.11.7 + caddy-dns

[Docker Hub](https://hub.docker.com/r/kairyou/caddy-docker)

```sh
docker pull kairyou/caddy-docker:2.11.7
```

DNS providers: DNSPod, Alidns, Gandi, and Cloudflare. Provider versions are pinned
in the Dockerfile; DNSPod uses an upstream commit compatible with the libdns API.

Pushes to `main` and manual runs of the Docker Image CI workflow build and publish
`linux/amd64` and `linux/arm64` images with the `2.11.7`, `latest`, and build date
tags. The workflow summary records the published image digest. Use the version
tag or the verified digest for deployments, and test the published image before
upgrading an existing application.

When upgrading Caddy, update both Dockerfile base versions, the `xcaddy build`
version, and the workflow's `VERSION` value.
