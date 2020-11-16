#!/bin/bash

set -e

# Install Developer Toolset 9
sudo yum install -y devtoolset-9

# Install cmake 3.18.4
cd ~
wget https://github.com/Kitware/CMake/releases/download/v3.18.4/cmake-3.18.4-Linux-x86_64.sh
chmod +x cmake-3.18.4-Linux-x86_64.sh
sudo scl enable devtoolset-9 -- ./cmake-3.18.4-Linux-x86_64.sh --skip-license --prefix=/usr/local

# Install Java 11
sudo yum install -y java-11-openjdk-devel
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.9.11-0.0.1.el7_9.x86_64/

# Install libbsd & libuuid
sudo yum install -y libbsd libuuid git

# Build Aeron
cd ~
git clone https://github.com/real-logic/aeron.git
cd aeron
mkdir -p cppbuild/Debug
cd cppbuild/Debug

scl enable devtoolset-9 -- cmake ../..
scl enable devtoolset-9 -- cmake --build . --clean-first
# scl enable devtoolset-9 -- ctest

# Install Docker
sudo yum-config-manager --enable *addons
sudo yum install -y docker-engine
sudo usermod -a -G docker $USER
sudo systemctl enable docker
