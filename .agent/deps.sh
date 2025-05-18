#!/usr/bin/env bash

set -euo pipefail
set -x

apt update -y;
apt install -y build-essential autoconf automake libtool pkg-config \
    libgoogle-glog-dev libleveldb-dev libpopt-dev \
    libgtest-dev python-dev-is-python3 swig default-jdk flex bison cython3 gperf \
    libsparsehash-dev \
    libbsd-dev \
    autoconf-archive;

# libbsd-dev for libmacaroons

# limit to 8 threads to avoid OOM
THREADS=$(nproc)
if [ "$THREADS" -gt 8 ]; then
    THREADS=8
fi

for repo in "po6" "e" "busybee" "HyperLevelDB" "libmacaroons" "libtreadstone" "Replicant"; do
    git clone https://github.com/AaronFriel/$repo.git || true
    cd $repo
    autoreconf -i
    ./configure
    make -j$THREADS
    make install
    ldconfig
    cd ..
done

autoreconf -i
./configure --prefix=/opt/hyperdex
make;
make check;