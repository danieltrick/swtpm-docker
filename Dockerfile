# Docker file for SWTPM
FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

ARG LTPMS_COMMIT=92ab42119406d6c8f9adda8d202205e82eb99d79
ARG SWTPM_COMMIT=d6ca69ad4622e25c6ef2d49820ed92df7b42b89e

# Install libtpms and swtpm dependencies
RUN apt-get update && \
    apt-get install -y \
    autoconf \
    build-essential \
    curl \
    libgmp-dev \
    libjson-glib-dev \
    libseccomp-dev \
    libssl-dev \
    libtasn1-6-dev \
    libtool \
    pkg-config

# Build libtpms
RUN mkdir -p /tmp/libtpms-src \
    && curl --tlsv1.2 -sSfL https://github.com/stefanberger/libtpms/archive/${LTPMS_COMMIT}.tar.gz | tar -C /tmp/libtpms-src --strip-components=1 -xzv \
    && cd /tmp/libtpms-src \
    && ./autogen.sh --prefix=/opt/swtpm $LIBTPMS_AUTOGEN_EXTRA --with-openssl --with-tpm2 --disable-tests \
    && make -j$(nproc) \
    && make install \
    && cd ~ \
    && rm -vfr /tmp/libtpms-src

# Build SWTPM
RUN mkdir -p /tmp/swtpm-src \
    && curl --tlsv1.2 -sSfL https://github.com/stefanberger/swtpm/archive/${SWTPM_COMMIT}.tar.gz | tar -C /tmp/swtpm-src --strip-components=1 -xzv \
    && cd /tmp/swtpm-src \
    && PKG_CONFIG_PATH=/opt/swtpm/lib/pkgconfig ./autogen.sh --prefix=/opt/swtpm --libdir=/opt/swtpm/lib --disable-tests \
    && make -j$(nproc) $SWTPM_MAKE_EXTRA \
    && make install \
    && cd ~ \
    && rm -vfr /tmp/swtpm-src

# Start SWTPM Server
ENTRYPOINT ["/opt/swtpm/bin/swtpm"]
CMD ["socket", "--tpm2", "--server", "port=2321,bindaddr=0.0.0.0,disconnect", "--ctrl", "type=tcp,port=2322,bindaddr=0.0.0.0", "--flags", "not-need-init"]
