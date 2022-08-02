#!/bin/sh -f
echo "=================================="
echo "-----INITIALIZATION-----"
echo "=================================="
echo
sudo apt-get update
sudo apt-get -y upgrade
sudo apt install software-properties-common
echo "\r" | sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt -y install python3.8
sudo apt-get -y install python3-distutils
sudo apt -y install python3-tk
sudo apt install ngspice
echo
echo "=================================="
echo "-----INSTALLING DOCKER-----"
echo "=================================="
echo
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
apt-cache madison docker-ce
echo
echo "Select the required version string from above listed docker repo.The version string is the string in second column of above list"
echo
echo "For example,5:19.03.12~3-0~ubuntu-bionic"
echo
echo -e "\e[7mEnter the required version string\e[27m: "
read ver_str
sudo apt-get install docker-ce=$ver_str docker-ce-cli=$ver_str containerd.io
sudo usermod -aG docker $user_name
sudo systemctl stop docker
sudo systemctl start docker
sudo systemctl enable docker
echo

echo "=================================="
echo "----BUILDING OPENLANE----"
echo "=================================="
echo
sudo apt install -y build-essential python3 python3-venv python3-pip
cd $HOME/tools
mkdir openlane_working_dir
cd openlane_working_dir
mkdir pdks
export PDK_ROOT=$HOME/tools/openlane_working_dir/pdks
git clone https://github.com/efabless/openlane.git
cd openlane
make openlane
make pdk
cd $HOME
chown -R $user_name:$group_name work
echo
echo "######CONGRATULATIONS YOU ARE DONE!!########"
echo