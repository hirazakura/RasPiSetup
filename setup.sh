#!/bin/bash
echo "#-[RaspberryPi set up]--------------------------------------#\n"
echo " setup1:Initial setting"
echo " setup2:Update & Upgrade, Install vim & Git"
echo " setup3:Create a new user"
echo " setup4:Install pyenv & python"
echo " setup5:Install python"
echo " Please run by entering the setup number 1~5."
echo "#-----------------------------------------------------------#\n\n"
echo "setup number:"
read setupnum

echo "Execute"
echo -n "Ready?? >> "
read dummy

if [ $setupnum -eq 1 ]; then
    # 初期設定
    sudo raspi-config
fi

if [ $setupnum -eq 2 ]; then
    # aptのアップデート
    yes | sudo apt-get update
    yes | sudo apt-get upgrade
    # 本体ファームウェアアップデート
    yes | sudo apt-get install rpi-update
    sudo rpi-update
    # vimインストール
    yes | sudo apt-get install vim
    # Gitインストール
    yes | sudo apt-get install git
    # 再起動
    sudo reboot
fi

if [ $setupnum -eq 5 ]; then
    # 新規ユーザー設定
    echo -n "What user name? : "
    read username
    sudo adduser ${username}
    groups=`groups pi | sed -e "s/.*\:\(\)/\1/" | sed -e "s/^[ ]*//g" | sed -e "s/ /,/g"`
    sudo usermod -G ${groups} ${username}
    # 再起動
    sudo reboot
fi

if [ $setupnum -eq 4 ]; then
    echo -n "What install python version? : "
    read piversion
    yes | sudo apt-get install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev
    yes | sudo apt-get install libncursesw5-dev libffi-dev libreadline6-dev libdb5.3-dev libgdbm-dev libexpat1-dev liblzma-dev zlib1g-dev libc6-dev
    git clone git://github.com/yyuu/pyenv.git ~/.pyenv
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
    echo 'eval "$(pyenv init -)"' >> ~/.profile
    source ~/.profile
    pyenv install ${piversion}
    pyenv global ${piversion}
    pip install --upgrade pip
    pip install pyserial
    # 再起動
    sudo reboot
fi

if [ $setupnum -eq 5 ]; then
    echo -n "What install python version? : "
    read piversion
    yes | sudo apt-get install build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev
    wget https://www.python.org/ftp/python/${piversion}/Python-${piversion}.tgz
    tar -zxvf Python-${piversion}.tgz
    cd Python-${piversion}
    ./configure
    sudo make
    sudo make install
    python3 -V
    pip3 -V
    pip3 install -U pip
    pip3 install -U setuptools
    yes | sudo pip3 install -U pip
    yes | sudo pip3 install -U setuptools
    pip3 install pyserial
    yes | sudo pip3 install pyserial
fi