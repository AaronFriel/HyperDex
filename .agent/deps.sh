#!/usr/bin/env bash

set -euo pipefail
set -x

sudo apt update -y
sudo apt install -y build-essential autoconf automake libtool pkg-config \
    libgoogle-glog-dev libleveldb-dev libpopt-dev \
    libgtest-dev python-dev-is-python3 swig default-jdk flex bison cython3 gperf \
    libsparsehash-dev pandoc \
    libbsd-dev \
    autoconf-archive &
APT_PID=$!

make -C "$(dirname "$0")" clones

wait "$APT_PID"

# libbsd-dev for libmacaroons

# limit to 8 threads to avoid OOM
THREADS=$(nproc)
if [ "$THREADS" -gt 8 ]; then
    THREADS=8
fi

# Building HyperDex is handled separately

