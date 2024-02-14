#!/usr/bin/env bash

add-apt-repository ppa:ubuntu-toolchain-r/test
apt-get update
apt-get install -y gcc-9 gfortran-9

update-alternatives \
        --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 \
        --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-9 \
        --slave /usr/bin/gcov gcov /usr/bin/gcov-9
		

mkdir -p /opt/intel
chown $USER:$USER /opt/intel

wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB

apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB
rm GPG-PUB-KEY-INTEL-SW-PRODUCTS-2023.PUB

echo "deb https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list

apt-get update
apt-get install -y intel-oneapi-compiler-fortran intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic intel-oneapi-mkl intel-oneapi-mkl-devel

source /opt/intel/oneapi/setvars.sh
source /opt/intel/oneapi/compiler/2024.0/env/vars.sh

pip install meson==0.58.0 ninja

set -ex
export FC=ifort CC=icc

meson setup _build \
  ${MESON_ARGS:---prefix=$PWD/qcxms_bin --libdir=lib} \
  --buildtype=release \
  -Dfortran_link_args=-qopenmp

meson compile -C _build

meson install -C _build --no-rebuild