# Alpine Version
ARG ALPINE_VERS=3.20.2

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Stage #1
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FROM alpine:$ALPINE_VERS AS build

# SWTPM Versions
ARG LTPMS_COMMIT=2dc1af12e5b09a7f9eaf2dee47737b63ddfd7cb7
ARG SWTPM_COMMIT=54583a87b53623dbb04f9318c68e3d85246a6f9d

# Install build dependencies
RUN apk add --no-cache \
    autoconf \
    automake \
    bash \
    build-base \
    curl \
    expect \
    gawk \
    gmp-dev \
    gnutls \
    gnutls-dev \
    gnutls-utils \
    json-glib-dev \
    libseccomp-dev \
    libtasn1-dev \
    libtool \
    make \
    openssl-dev \
    py3-cryptography \
    py3-pip \
    py3-setuptools \
    py3-twisted \
    python3 \
    socat \
    softhsm

# Build libtpms
RUN mkdir -p /tmp/libtpms-src \
    && curl --tlsv1.2 -sSfL https://github.com/stefanberger/libtpms/archive/${LTPMS_COMMIT}.tar.gz | tar -C /tmp/libtpms-src --strip-components=1 -xzv \
    && cd /tmp/libtpms-src \
    && ./autogen.sh --prefix=/usr --libdir=/usr/lib --with-tpm2 --with-openssl \
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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Stage #2
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FROM alpine:$ALPINE_VERS

# Install runtime dependencies
RUN apk add --no-cache \
    json-glib \
    libseccomp

# Copy libtpms library
COPY --from=build \
    /usr/lib/libtpms.so.0 \
    /usr/lib/

# Copy SWTPM libraries
COPY --from=build \
    /usr/lib/swtpm/libswtpm_libtpms.so.0 \
    /usr/lib/swtpm/

# Copy SWTPM executable
COPY --from=build \
    /usr/bin/swtpm \
    /usr/bin/

# Start SWTPM Server
ENTRYPOINT ["/usr/bin/swtpm"]
CMD ["socket", "--tpm2", "--server", "port=2321,bindaddr=0.0.0.0", "--ctrl", "type=tcp,port=2322,bindaddr=0.0.0.0"]
