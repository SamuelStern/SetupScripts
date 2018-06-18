#!/bin/bash
 
#MOAB Installation
INSTALL_ROOT=$HOME
cd $INSTALL_ROOT
mkdir MOAB
cd MOAB
mkdir bld
MOAB_INSTALL_DIR=$INSTALL_ROOT/MOAB/install
mkdir $MOAB_INSTALL_DIR
git clone https://bitbucket.org/fathomteam/moab

cd moab
cd ../bld
cmake ../moab -DCMAKE_INSTALL_PREFIX=$MOAB_INSTALL_DIR \
 -DHDF5_ROOT=/usr/lib/x86_64-linux-gnu/hdf5/serial/ -DENABLE_HDF5=ON \
 -DENABLE_BLASLAPACK=OFF
make -j4
make check
make install

#Bandaid code, to make master branch work neatly with DAGMC in script
echo 'set(MOAB_INCLUDE_DIRS "/root/MOAB/install/include" "/usr/include/eigen3")'\
>>/root/MOAB/install/lib/cmake/MOAB/MOABConfig.cmake

printf '\nConsider adding the following lines to .bashrc:\n'
printf 'export PATH=$MOAB_INSTALL_DIR/bin:$PATH\n'
export PATH=$MOAB_INSTALL_DIR/bin:$PATH
printf 'export LD_LIBRARY_PATH=$MOAB_INSTALL_DIR/lib:$LD_LIBRARY_PATH\n'
export LD_LIBRARY_PATH=$MOAB_INSTALL_DIR/lib:$LD_LIBRARY_PATH

cd $INSTALL_ROOT
