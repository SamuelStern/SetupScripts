#!/bin/bash

#DAGMC Directory Setup
source install_dir.sh
mkdir $INSTALL_ROOT
cd $INSTALL_ROOT
mkdir DAG-mcnp
cd DAG-mcnp
git clone -b amalgamation https://github.com/SamuelStern/DAGMC.git
mkdir bld

DAGMC_INSTALL_DIR=$INSTALL_ROOT/DAG-mcnp/install
MOAB_CONFIG_DIR=$INSTALL_ROOT/MOAB/lib/cmake/MOAB
mkdir $DAGMC_INSTALL_DIR

#MCNP Source code patch
cd $INSTALL_ROOT/DAG-mcnp/DAGMC/src/mcnp/mcnp6
cp -r $INSTALL_ROOT/MY_MCNP/MCNP_CODE/MCNP620/Source .
chmod -R u+rw Source
patch -p0 < patch/mcnp620.patch

#Building/Installation
cd $INSTALL_ROOT/DAG-mcnp/bld
cmake ../DAGMC -DCMAKE_INSTALL_PREFIX=$DAGMC_INSTALL_DIR \
 -DMOAB_CMAKE_CONFIG=$MOAB_CONFIG_DIR \
 -DMOAB_DIR=$INSTALL_ROOT/MOAB \
 -DBUILD_MCNP6=ON
make 
make install
run-parts ../install/tests

cd $INSTALL_ROOT
