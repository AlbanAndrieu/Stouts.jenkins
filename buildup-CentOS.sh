#!/bin/bash -x

VAGRANT_HOME=/home/vagrant

#TODO use ansible instead
echo "###################"
echo "Add Misys DNS basic config"
sudo cat > /etc/resolv.conf <<EOL
domain misys.global.ad
search misys.global.ad
nameserver 10.21.200.3
nameserver 10.25.200.3
EOL

#install required packages
#TODO use ansible instead
#sudo yum install java-1.7.0-openjdk -y
#For ansible Error: ansible requires the stdlib json or simplejson module, neither was found!
sudo yum install -y python-simplejson

#perl dependencies
#TODO use ansible instead
#sudo yum install perl-XML-DOM perl-libwww-perl perl-XML-Handler-YAWriter perl-XML-SimpleObject perl-XML-Simple perl-File-Copy-Recursive perl-File-Find-Rule -y

echo "Done with buildup.sh"
