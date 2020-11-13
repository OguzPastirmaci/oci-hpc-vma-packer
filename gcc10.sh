#!/bin/bash

set -e

# Build GCC 10.2.0
cd ~
wget https://ftpmirror.gnu.org/gcc/gcc-10.2.0/gcc-10.2.0.tar.xz
tar xf gcc-10.2.0.tar.xz
cd gcc-10.2.0
contrib/download_prerequisites

cd ~
mkdir build && cd build
../gcc-10.2.0/configure -v --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu --prefix=/usr/local/gcc-10.2.0 --enable-checking=release --enable-languages=c,c++,fortran --disable-multilib --program-suffix=-10.2

make
sudo make install-strip

export PATH=/usr/local/gcc-10.2.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/gcc-10.2.0/lib64:$LD_LIBRARY_PATH

# Build AERON

# Install cmake 3.18.4
cd ~
wget https://github.com/Kitware/CMake/releases/download/v3.18.4/cmake-3.18.4-Linux-x86_64.sh
chmod +x cmake-3.18.4-Linux-x86_64.sh
sudo ./cmake-3.18.4-Linux-x86_64.sh --skip-license --prefix=/usr/local

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

CC=/usr/local/gcc-10.2.0/bin/gcc-10.2 CXX=/usr/local/gcc-10.2.0/bin/g++-10.2 cmake ../..
CC=/usr/local/gcc-10.2.0/bin/gcc-10.2 CXX=/usr/local/gcc-10.2.0/bin/g++-10.2 cmake --build . --clean-first
# CC=/usr/local/gcc-10.2.0/bin/gcc-10.2 CXX=/usr/local/gcc-10.2.0/bin/g++-10.2 ctest

# Install Docker
sudo yum-config-manager --enable *addons
sudo yum install -y docker-engine
sudo usermod -a -G docker $USER
sudo systemctl enable docker
