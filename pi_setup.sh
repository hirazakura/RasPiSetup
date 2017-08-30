#!/bin/bash
echo "#-[RaspberryPi set up]--------------------------------------#\n"
echo " This script has been written for RaspberryPi."
echo " setup1:Initial setting"
echo " setup2:Update & Upgrade, Install vim"
echo " setup3:Setting a Static IP Addres"
echo " setup4:Setting up a wireless network"
echo " setup5:Create a new user"
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
    # 再起動
    sudo reboot
fi

if [ $setupnum -eq 3 ]; then
    # 有線LAN設定
    echo -n "What IP address? : "
    read ip_address
    echo -n "What Default gateway? : "
    read default_gateway
    echo -n "What DNS? : "
    read dns
    {
        echo "interface eth0"
        echo "static ip_address=${ip_address}"
        echo "static routers=${default_gateway}"
        echo "static domain_name_servers=${dns}"
    } >> /etc/dhcpcd.conf

    {
        echo "static ip_address=${ip_address}"
        echo "static routers=${default_gateway}"
        echo "static domain_name_servers=${dns}"
    } >> /etc/dhcpcd.conf
    # 再起動
    sudo reboot
fi

if [ $setupnum -eq 4 ]; then
    echo -n "What SSID? : "
    read ssid
    echo -n "What PASS? : "
    read pass
    # 無線LAN設定
    sudo sh -c "wpa_passphrase ${ssid} ${pass} >> /etc/wpa_supplicant/wpa_supplicant.conf"
    sudo sed -e "/#psk/d" /etc/wpa_supplicant/wpa_supplicant.conf
fi

if [ $setupnum -eq 5 ]; then
    # 新規ユーザー設定
    echo -n "What user name? : "
    read name
    sudo adduser ${name}
    groups=`groups pi | sed -e "s/.*\:\(\)/\1/" | sed -e "s/^[ ]*//g" | sed -e "s/ /,/g"`
    sudo usermod -G ${groups} ${name}
    # 再起動
    sudo reboot
fi
