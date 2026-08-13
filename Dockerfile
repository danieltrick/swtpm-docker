# Alpine Version
ARG ALPINE_VERS=3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Stage #1
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FROM alpine:$ALPINE_VERS AS build

# SWTPM Versions
ARG SWTPM_COMMIT=db2386b2c1530de3a7fa57a8214c3630e785ec2f
ARG LTPMS_COMMIT=0356d4339bcb1c8f309d99658ba604c35f7f2894

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
    openssl \
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
    gmp \
    json-glib \
    libseccomp \
    libtasn1 \
    openssl

# Copy libtpms library
COPY --from=build \
    /usr/lib/libtpms.so* \
    /usr/lib/

# Copy SWTPM libraries
COPY --from=build \
    /usr/lib/swtpm/libswtpm_libtpms.so* \
    /usr/lib/swtpm/

# Copy configuration files
COPY --from=build \
    /etc/swtpm* \
    /etc/

# Copy SWTPM executable
COPY --from=build \
    /usr/bin/swtpm* \
    /usr/bin/

# Create 'tpmstate' directory
RUN mkdir -p /var/lib/swtpm/tpmstate

# Start SWTPM Server
ENTRYPOINT ["/usr/bin/swtpm"]
CMD ["socket", "--tpm2", \
    "--server", "type=tcp,port=2321,bindaddr=0.0.0.0", \
    "--ctrl",   "type=tcp,port=2322,bindaddr=0.0.0.0", \
    "--flags", "not-need-init", \
    "--tpmstate", "dir=/var/lib/swtpm/tpmstate"]
