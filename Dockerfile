# Docker file for SWTPM
FROM alpine:3.20.2

# Versions
ARG LTPMS_COMMIT=2dc1af12e5b09a7f9eaf2dee47737b63ddfd7cb7
ARG SWTPM_COMMIT=54583a87b53623dbb04f9318c68e3d85246a6f9d

# Install required dependencies
RUN apk add --no-cache \
    autoconf \
    automake \
    bash \
    build-base \
    curl \
    gmp-dev \
    gnutls-dev \
    json-glib-dev \
    libseccomp-dev \
    libtasn1-dev \
    libtool \
    make \
    openssl-dev

# Build libtpms
RUN mkdir -p /tmp/libtpms-src \
    && curl --tlsv1.2 -sSfL https://github.com/stefanberger/libtpms/archive/${LTPMS_COMMIT}.tar.gz | tar -C /tmp/libtpms-src --strip-components=1 -xzv \
    && cd /tmp/libtpms-src \
    && ./autogen.sh --prefix=/usr --libdir=/usr/lib --with-tpm2 --with-openssl --disable-tests \
    && make -j$(nproc) \
    && make -j$(nproc) install \
    && cd - \
    && rm -vfr /tmp/libtpms-src

# Build SWTPM
RUN mkdir -p /tmp/swtpm-src \
    && curl --tlsv1.2 -sSfL https://github.com/stefanberger/swtpm/archive/${SWTPM_COMMIT}.tar.gz | tar -C /tmp/swtpm-src --strip-components=1 -xzv \
    && cd /tmp/swtpm-src \
    && ./autogen.sh --prefix=/usr --libdir=/usr/lib --with-openssl --disable-tests \
    && make -j$(nproc) \
    && make -j$(nproc) install \
    && cd - \
    && rm -vfr /tmp/swtpm-src

# Start SWTPM Server
ENTRYPOINT ["/usr/bin/swtpm"]
CMD ["socket", "--tpm2", "--server", "port=2321,bindaddr=0.0.0.0", "--ctrl", "type=tcp,port=2322,bindaddr=0.0.0.0"]
