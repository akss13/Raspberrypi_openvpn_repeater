#!/bin/bash
trap 'sudo rm -rdf /etc/resolv.conf && sudo mv /etc/resolv.conf.orig /etc/resolv.conf ' EXIT

# while [ true ]; do
#     echo "running" >hale.txt
#     sleep 5s
# done
echo "Enter .ovpn file path"
read var
function driver() {
    if [ $(id -u) != 0 ]; then
        echo "Run the script as root"
    elif [ -z "$var" ]; then
        echo "enter client file absoulute path"
    else
        autossh -D 8008 root@162.243.166.99 -f -p 443
        sudo openvpn "$var" &
        sudo cp /etc/resolv.conf /etc/resolv.conf.orig
        echo "nameserver 8.8.8.8">/etc/resolv.conf
    fi
}
driver
#~/ucl.ovpn
