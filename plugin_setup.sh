#!/bin/bash
 
#Finally, install the actual svalinn plugin
source install_dir.sh
cd $INSTALL_ROOT
mkdir svalinn_plugin
cd svalinn_plugin
git clone https://github.com/svalinn/DAGMC-Trelis.git
cd DAGMC-Trelis
git clone -b use_eigen --single-branch https://github.com/SamuelStern/mcnp2cad
cd ..
mkdir bld
cd bld

cmake ../DAGMC-Trelis -DCMAKE_PREFIX_PATH=/opt/Trelis-16.3/bin/ -DBUILD_DAGMC_EXPORTER=OFF\
 -DBUILD_MCNP_IMPORTER=OFF -DBUILD_IGEOM=ON
cmake ../DAGMC-Trelis/ -DCMAKE_PREFIX_PATH=/opt/Trelis-16.3/bin/ -DBUILD_DAGMC_EXPORTER=OFF\
 -DBUILD_MCNP_IMPORTER=ON
make
PLUGINDIR=/opt/Trelis-16.3/bin/plugins/svalinn
mkdir $PLUGINDIR
cp libsvalinn_plugin.so $PLUGINDIR
cp libiGeom.so $PLUGINDIR
cp $INSTALL_ROOT/MOAB/lib/libMOAB.so.5 $PLUGINDIR
cp $INSTALL_ROOT/DAG-mcnp/install/lib/libmakeWatertight.so $PLUGINDIR
cd ../DAGMC-Trelis
cp install.sh $PLUGINDIR
cd $PLUGINDIR/../..
bash plugins/svalinn/install.sh

cd $INSTALL_ROOT
