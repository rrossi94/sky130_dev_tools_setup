#!/bin/sh -f
cd
cd $HOME/tools
mkdir pdks
cd pdks
echo
echo "=================================="
echo "-----INSTALLING SKYWATER PDK------"
echo "=================================="
echo
git clone https://github.com/google/skywater-pdk
cd skywater-pdk
git submodule init libraries/sky130_fd_io/latest
git submodule init libraries/sky130_fd_pr/latest
git submodule init libraries/sky130_fd_sc_hd/latest
git submodule init libraries/sky130_fd_sc_hdll/latest
git submodule init libraries/sky130_fd_sc_hs/latest
git submodule init libraries/sky130_fd_sc_ms/latest
git submodule init libraries/sky130_fd_sc_ls/latest
git submodule init libraries/sky130_fd_sc_lp/latest
git submodule init libraries/sky130_fd_sc_hvl/latest
git submodule update
make timing 
cd ..

echo
echo "=================================="
echo "-----INSTALLING OPEN PDKS---------"
echo "=================================="
echo
git clone https://github.com/RTimothyEdwards/open_pdks.git
cd open_pdks
mkdir -p $HOME/tools/pdks/skywater130
./configure --enable-sky130-pdk=$HOME/tools/pdks/skywater-pdk --with-sky130-local-path=$HOME/tools/pdks --with-ef-style
cd sky130
mkdir -p sky130A 
mkdir -p sky130B
make
sudo make install

# This will download and install the SkyWater SKY130 PDK, the SKY130 setup
#     files for xschem, and a third-party library containing alphanumeric layouts.
#     If you prefer an installation in your user space, then use configure option
#     "--with-sky130-local-path=<path>" with <path> being some alternative like
#     ~/pdks, and "make install" does not need to be run sudo.

#     With he above configuration line, the PDK files will be installed into
#     the path
# 		/usr/share/pdks/sky130A/