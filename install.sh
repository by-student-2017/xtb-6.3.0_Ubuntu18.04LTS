#!/bin/bash

mv ./param_gfnff.xtb ./.param_gfnff.xtb
mv ./travis.yml ./.travis.yml
mv ./xtbrc ./.xtbrc
mv ./zenodo.json ./.zenodo.json

sudo apt update
sudo apt install -y gcc g++ build-essential gfortran cmake liblapack-dev libblas-dev libopenblas-dev
export FC="gfortran -O2 -mtune=native" CC=gcc
mkdir build
pushd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
ctest
popd
sudo make -C build install

echo ' ' >> ~/.bashrc
echo '# xtb settings' >> ~/.bashrc
echo 'export XTBHOME=$HOME/xtb-6.3.0' >> ~/.bashrc
echo 'export XTBPATH=${XTBHOME}/build:${XTBHOME}:${HOME}' >> ~/.bashrc
echo 'export MANPATH=${MANPATH}:${XTBHOME}/man' >> ~/.bashrc
echo 'export PATH=${PATH}:${XTBHOME}/build' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${XTBHOME}/include:${XTBHOME}/scripts' >> ~/.bashrc
echo 'export PYTHONPATH=${PYTHONPATH}:${XTBHOME}/python' >> ~/.bashrc

bash
