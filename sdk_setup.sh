#!/bin/bash
 
#Trelis SDK installation
cd /opt/Trelis-16.3
mkdir sdk
cd sdk
echo Enter netID:
read username
curl -1 -v --disable-epsv --ftp-skip-pasv-ip -u $username@wisc.edu\
 --ftp-ssl  --output trelisSDK.gz\
 ftp://ftp.box.com/CNERG/INTERNAL/Resources/Trelis/SDK/Trelis-SDK-16.0.0-Lin64.tar.gz >trelisSDK.gz
tar -xzf trelisSDK.gz 
cd ../bin
sudo ln -s ../sdk/bin/* .
cd ..
sudo ln -s sdk/include .

cd $HOME
