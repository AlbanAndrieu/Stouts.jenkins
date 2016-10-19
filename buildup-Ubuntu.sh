#!/bin/bash

VAGRANT_HOME=/home/vagrant
ANSIBLE_PATH=$VAGRANT_HOME/.ansible

#TODO use ansible instead
echo "###################"
echo "Add Misys DNS basic config"
rm /etc/resolvconf/resolv.conf.d/base
echo "nameserver 10.21.200.3" > /etc/resolvconf/resolv.conf.d/base
echo "nameserver 10.25.200.3" >> /etc/resolvconf/resolv.conf.d/base
sudo service resolvconf restart

echo "###################"
echo "See rsyn and ansible issue : https://github.com/ansible/ansible-modules-core/issues/2781"
rsync --version
echo "###################"

echo "Done with buildup.sh"
