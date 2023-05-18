#!/bin/bash
# Install John the Ripper jumbo
# See https://github.com/openwall/john
# See https://github.com/openwall/john/blob/bleeding-jumbo/doc/INSTALL-UBUNTU
apt-get -y install git build-essential libssl-dev zlib1g-dev yasm pkg-config libgmp-dev libpcap-dev libbz2-dev ocl-icd-opencl-dev opencl-headers pocl-opencl-icd
rm -rf john 2>/dev/null
git clone --depth 1 https://github.com/openwall/john -b bleeding-jumbo john
cd john/src
./configure --disable-openmp && make -s clean && make -sj4
mv ../run/john ../run/john-non-omp
./configure CPPFLAGS='-DOMP_FALLBACK -DOMP_FALLBACK_BINARY="\"john-non-omp\""'
make -s clean && make -sj4
../run/john --test=0 | grep -F "Testing: HMAC-SHA"
