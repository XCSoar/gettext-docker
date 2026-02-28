FROM debian:trixie-slim AS builder

ARG GETTEXT_VERSION=1.0

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  curl \
  file \
  gawk \
  pkg-config \
  texinfo \
  xz-utils \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN curl -fsSLO \
  "https://ftp.gnu.org/gnu/gettext/gettext-${GETTEXT_VERSION}.tar.gz" \
  && tar -xzf "gettext-${GETTEXT_VERSION}.tar.gz" \
  && cd "gettext-${GETTEXT_VERSION}" \
  && ./configure \
    --prefix=/opt/gettext \
    --disable-java \
    --disable-csharp \
    --without-emacs \
  && make -j"$(nproc)" \
  && make install \
  && /opt/gettext/bin/gettext --version

FROM debian:trixie-slim

ARG GETTEXT_VERSION=1.0

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  libunistring5 \
  libxml2 \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/gettext /opt/gettext

ENV PATH="/opt/gettext/bin:${PATH}"

WORKDIR /work

CMD ["gettext", "--version"]
