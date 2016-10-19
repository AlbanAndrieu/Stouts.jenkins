#!/bin/sh

#export VAGRANT_VAGRANTFILE=${WORKSPACE}/Scripts/ansible/roles/jenkins-UAT-master/Vagrantfile
echo "###################"
echo "Documentation available at :"
echo "http://almtools/confluence/display/ENG/Jenkins+-+UAT"
echo "###################"
echo "List VMS"
VBoxManage list vms
echo "List running VMS"
VBoxManage list runningvms
echo "###################"
#echo "Power off Jenkins slave"
#VBoxManage controlvm slave01 poweroff || true
#echo "Delete master VM"
#VBoxManage controlvm master acpipowerbutton || true
#VBoxManage controlvm master poweroff || true
#VBoxManage unregistervm master --delete || true
#vagrant destroy master
echo "###################"
vagrant status
vagrant global-status
#vagrant global-status --prune
#vagrant up --debug
vagrant up || true
#vagrant up || exit 1
vagrant ssh-config master
echo "###################"
#echo "Add Jenkins master UAT VM key to 10.21.22.69 jenkins user"
#ssh-keygen -f "/home/jenkins/.ssh/known_hosts" -R [10.21.22.69]:2233
echo "###################"
echo "Refresh and start Jenkins"
ansible --version
echo "WORKSPACE : ${WORKSPACE}"
cd ${WORKSPACE}/Scripts/ansible/
sleep 30
export ANSIBLE_REMOTE_USER=vagrant
export ANSIBLE_PRIVATE_KEY_FILE=$HOME/.vagrant.d/insecure_private_key
ssh-add $ANSIBLE_PRIVATE_KEY_FILE
ansible -m setup master -i hosts --user=vagrant -vvvv
ansible-playbook jenkins-UAT.yml -i hosts -vvvv || exit 1
echo "Connecting to master"
#vagrant ssh-config
#ssh -p 2233 vagrant@10.21.22.69 "echo \"DONE\""
