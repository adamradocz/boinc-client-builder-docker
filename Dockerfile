FROM ubuntu:bionic

LABEL description="This container will allow you to build a BOINC Client .deb file without installing any build dependencies on your system."

# Global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
    BOINC_VERSION="7.10.2"

# Install the dependencies
RUN apt-get update && apt-get install -y \
    git \
    make m4 libtool autoconf automake gcc pkg-config \
    openssl libcurl4 libcurl4-openssl-dev libssl-dev libnotify-dev \
    checkinstall \
    && rm -rf /var/lib/apt/lists/*

# Download the source code
RUN git clone https://github.com/BOINC/boinc boinc

# Build
RUN cd boinc && \
    git checkout client_release/$(echo $BOINC_VERSION | head -c 1)/$BOINC_VERSION && \
    ./_autosetup && \
    ./configure --disable-server --disable-manager CXXFLAGS="-O3" && \
    make && \
    cd client && \
    checkinstall -Dy --pkgname=boinc-client --pkgversion=$BOINC_VERSION --install=no --nodoc && \
    mkdir /build && \
    cp *.deb /build/
