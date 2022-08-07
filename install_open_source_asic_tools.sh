#!/bin/sh -f

cd
sudo apt-get install -y vim htop git
sudo apt-get install -y build-essential
sudo apt-get install -y libtool autoconf automake binutils  bison flex gcc gcc-c++ gettext libtool make patch pkgconfig redhat-rpm-config rpm-build rpm-sign ctags elfutils indent patchutils -y
sudo apt-get install -y texinfo
sudo apt-get install -y libx11-dev libxaw7-dev libreadline-dev
sudo apt-get install -y m4 vim tcl-dev tk-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev tcsh csh libx11-dev libcairo2-dev libncurses-dev
sudo apt-get install -y python3 python3-pip libgsl-dev libgtk-3-dev cmake
sudo apt-get install -y python3-venv
sudo apt-get install -y build-essential clang bison flex \
	libreadline-dev gawk tcl-dev libffi-dev git \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev

sudo apt-get install -y gengetopt help2man groff pod2pdf bison flex libhpdf-dev libtool autoconf octave liboctave-dev epstool transfig paraview
sudo apt-get install -y libhdf5-dev libvtk7-dev libboost-all-dev libcgal-dev libtinyxml-dev qtbase5-dev libvtk7-qt-dev
sudo apt-get install -y octave liboctave-dev
sudo apt-get install -y gengetopt help2man groff pod2pdf bison flex libhpdf-dev libtool
sudo apt-get install -y libopenmpi-dev
sudo apt install -y xterm graphicsmagick ghostscript
sudo apt install -y libtinyxml-dev libhdf5-serial-dev libcgal-dev vtk6 libvtk6-qt-dev
sudo apt install -y cython3 build-essential cython3 python3-numpy python3-matplotlib
sudo apt install -y python3-scipy python3-h5py
sudo apt-get install -y m4 vim tcl-dev tk-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev tcsh csh libx11-dev libcairo2-dev libncurses-dev


echo
echo "=================================="
echo "-----INSTALLING CMake-------------"
echo "=================================="
echo
mkdir tools
cd tools
wget "https://github.com/Kitware/CMake/releases/download/v3.13.0/cmake-3.13.0.tar.gz"
tar -xvzf cmake-3.13.0.tar.gz
cd cmake-3.13.0/
sudo ./bootstrap --prefix=/usr/local
sudo make -j$(nproc)
sudo make install 
cd ..
rm cmake-3.13.0.tar.gz
sudo apt-get install subscription-manager -y
sudo apt-get makecache
sudo apt-get info clang
sudo apt-get repolist
sudo apt-get install apt-get-utils -y
sudo apt-get-config-manager --enable extras
sudo apt-get makecache
sudo apt-get install clang -y
sudo apt-get install gsl -y
sudo apt-get install gsl-devel -y
sudo apt-get install tcl tk -y
sudo apt-get install tcl-devel -y
sudo apt-get install tk-devel -y
sudo ln -s /usr/bin/tclsh8.5 /usr/bin/tcl
sudo apt-get install readline-devel -y
sudo apt-get install -y https://centos7.iuscommunity.org/ius-release.rpm 
sudo apt-get update -y
sudo apt-get install -y python36u python36u-libs python36u-devel python36u-pip
sudo ln -s /usr/bin/python3.6 /usr/bin/python3
sudo apt-get install libffi-devel -y
sudo apt-get install graphviz -y

echo
echo "=================================="
echo "-----INSTALLING Yosys------------"
echo "=================================="
echo
git clone https://github.com/cliffordwolf/yosys.git
cd yosys/
make config-gcc
make
sudo make install
cd ..

echo
echo "=================================="
echo "-----INSTALLING Graywolf-----------"
echo "=================================="
echo
git clone https://github.com/rubund/graywolf.git
cd graywolf/
mkdir build
cd build
cmake ..
make
make install
cd ../../
apt-get install  xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps -y
sudo apt-get install libXt-devel -y

echo
echo "=================================="
echo "-----INSTALLING Qrouter-----------"
echo "=================================="
echo
sudo wget "http://opencircuitdesign.com/qrouter/archive/qrouter-1.4.85.tgz"
tar -xvzf qrouter-1.4.85.tgz
cd qrouter-1.4.85
sudo ./configure
sudo make
sudo make install
cd ..
rm qrouter-1.4.85.tgz

sudo apt-get install libX11-devel -y

echo
echo "=================================="
echo "-----INSTALLING Magic-------------"
echo "=================================="
echo
sudo wget "http://opencircuitdesign.com/magic/archive/magic-8.3.50.tgz"
tar -xvzf magic-8.3.50.tgz
cd magic-8.3.50
sudo ./configure
sudo make
sudo make install
cd ..
rm magic-8.3.50.tgz

echo
echo "=================================="
echo "-----INSTALLING NGSpice-----------"
echo "=================================="
echo
sudo wget "https://sourceforge.net/projects/ngspice/files/ngspice-37.tar.gz"
tar -xvzf ngspice-37.tar.gz
cd ngspice-37
mkdir release
cd release
../configure  --with-x --with-readline=yes --disable-debug
make
sudo make install
cd ../../
rm -rf ngspice-37.tar.gz

echo
echo "=================================="
echo "-----INSTALLING GTKWAVE-----------"
echo "=================================="
echo
sudo apt-get install gtkwave

echo
echo "=================================="
echo "-----INSTALLING Netgen------------"
echo "=================================="
echo
sudo wget "http://opencircuitdesign.com/netgen/archive/netgen-1.5.227.tgz"
tar -xvzf netgen-1.5.227.tgz
cd netgen-1.5.227
sudo ./configure
sudo make
sudo make install
cd ..
rm netgen-1.5.227.tgz
sudo ln -s /usr/local/bin/yosys /usr/bin/yosys
sudo ln -s /usr/local/bin/graywolf /usr/bin/graywolf
sudo ln -s /usr/local/bin/qrouter /usr/bin/qrouter
sudo ln -s /usr/local/bin/magic /usr/bin/magic
sudo ln -s /usr/local/bin/netgen /usr/bin/netgen
sudo ln -s /usr/local/bin/yosys-abc /usr/bin/yosys-abc

echo
echo "=================================="
echo "-----INSTALLING Qflow-------------"
echo "=================================="
echo
sudo wget "http://opencircuitdesign.com/qflow/archive/qflow-1.4.98.tgz"
tar -xvzf qflow-1.4.98.tgz
cd qflow-1.4.98
sudo ./configure
sudo make
sudo make install
cd ..
rm qflow-1.4.98.tgz
sudo ln -s /usr/local/bin/qflow /usr/bin/qflow
sudo apt-get install swig -y

echo
echo "=================================="
echo "-----INSTALLING Open STA----------"
echo "=================================="
echo
git clone https://github.com/The-OpenROAD-Project/OpenSTA.git
cd OpenSTA
mkdir build
cd build
cmake ..
make
cd ..
sudo ln -s $PWD/app/sta /usr/bin/sta
cd ..
wget "https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/t/tcllib-1.14-1.el7.noarch.rpm"
sudo rpm -Uvh tcllib-1.14-1.el7.noarch.rpm
sudo apt-get install tcllib
sudo apt-get install python36u-tkinter

echo
echo "=================================="
echo "-----INSTALLING XSCHEM 130-----"
echo "=================================="
echo
git clone https://github.com/StefanSchippers/xschem_sky130.git
git clone https://github.com/StefanSchippers/xschem.git
cd xschem
./configure --prefix=/usr/local --user-conf-dir=~/.xschem  \
--user-lib-path=~/share/xschem/xschem_library \
--sys-lib-path=/usr/local/share/xschem/xschem_library
make
sudo make install