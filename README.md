# gettext-docker

Docker image for GNU gettext, built from source with a pinned version
(`GETTEXT_VERSION`) and published to GHCR.

## Image

- `ghcr.io/xcsoar/gettext-docker:latest`

## Build locally

```bash
docker build -t gettext-docker:local .
```

Build with an explicit gettext version:

```bash
docker build --build-arg GETTEXT_VERSION=1.0 -t gettext-docker:1.0 .
```

## Test locally

```bash
docker run --rm gettext-docker:local gettext --version
```

## CI/CD

- GitHub Actions workflow: `.github/workflows/build-and-push.yml`
- Pull requests: build only (no push)
- Pushes to `main` and tags: publish image tags to GHCR

## Renovate

`renovate.json` is configured to update:

- GitHub Actions versions
- Docker base image tags in `Dockerfile`
- `GETTEXT_VERSION` in `Dockerfile`
