# Alpine Version
ARG ALPINE_VERS=3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Stage #1
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FROM alpine:$ALPINE_VERS AS build

# SWTPM Versions
ARG SWTPM_COMMIT=665486b8179fef6eba845e8437acd2da6ae2634e
ARG LTPMS_COMMIT=b4d81572c15b504a4e60b4b46c91d3ec0a92c79e

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
    gmp \
    gnutls-utils \
    libseccomp

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
