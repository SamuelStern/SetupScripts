#!/bin/bash
 
#MOAB Installation
INSTALL_ROOT=$HOME
cd $INSTALL_ROOT
mkdir MOAB
cd MOAB
mkdir bld
mkdir install
git clone https://bitbucket.org/fathomteam/moab
cd moab
git checkout Version5.0
cd ../bld
cmake ../moab -DCMAKE_INSTALL_PREFIX=$INSTALL_ROOT/MOAB/install -DHDF5_ROOT=/usr/lib/x86_64-linux-gnu/hdf5/serial/ -DENABLE_HDF5=ON
make -j4
make check
make install
printf 'export PATH=$PATH:$INSTALL_ROOT/MOAB/install/bin'>>$HOME/.bashrc
export PATH=$PATH:$INSTALL_ROOT/MOAB/install/bin
printf 'export LD_LIBRARY_PATH=$INSTALL_ROOT/MOAB/install/lib'>>$HOME/.bashrc
export LD_LIBRARY_PATH=$INSTALL_ROOT/MOAB/install/lib
