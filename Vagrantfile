# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

HOSTNAME_01 = "master1"
VAGRANT_BASE_PORT_01 = "33"
VAGRANT_SSH_PORT_01 = "22" + VAGRANT_BASE_PORT_01
VAGRANT_NETWORK_IP_01 = "192.168.11." + VAGRANT_BASE_PORT_01

HOSTNAME_02 = "master2"
VAGRANT_BASE_PORT_02 = "34"
VAGRANT_SSH_PORT_02 = "22" + VAGRANT_BASE_PORT_02
VAGRANT_NETWORK_IP_02 = "192.168.11." + VAGRANT_BASE_PORT_02

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # required to download the box if used for the first time
  # vagrant box add ubuntu14 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box
  config.vm.box = "ubuntu_trusty_x64"
  #config.vm.box = "hfm4/centos5"
  #config.vm.box = "hfm4/centos6"
  #config.vm.box = "hfm4/centos7"
  config.vm.boot_timeout = 600

  config.vm.define :master do |vagrant|
    vagrant.vm.hostname = HOSTNAME_01
    vagrant.vm.network :private_network, ip: VAGRANT_NETWORK_IP_01
    vagrant.vm.provider :virtualbox do |vb|
      vb.name = HOSTNAME_01
      vb.customize ["modifyvm", :id, "--memory", "8192"]
    end
    #vagrant.vm.provision "file", source: "../keys/id_rsa", destination: "id_rsa"
    #vagrant.vm.provision "file", source: "../keys/id_rsa.pub", destination: "id_rsa.pub"

    #vagrant.vm.provision :shell, :path => "buildup-CentOS.sh"
    vagrant.vm.provision :shell, :path => "buildup-Ubuntu.sh"

    #See issue vagrant forward port 22 unable to force
    #https://stackoverflow.com/questions/30669183/forwarding-the-ssh-port-fails-when-running-two-vagrant-instances-from-the-same-h
    #vagrant.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", disabled: "true"
    vagrant.vm.network "forwarded_port", guest: 22, host: VAGRANT_SSH_PORT_01, id: 'ssh', auto_correct: "true"
    vagrant.vm.network "forwarded_port", guest: 8380, host: 8380, auto_correct: true
    vagrant.vm.network "forwarded_port", guest: 33224, host: 33224, auto_correct: true
    vagrant.vm.network "forwarded_port", guest: 3141, host: 3141, auto_correct: true

    # Do not use a shared folder. We will fetch sources in other ways.
    # This allows us (eventually) to export the VM and move it around.
    vagrant.vm.synced_folder ".", "/vagrant", disabled: true

    #config.ssh.private_key_path = "../keys/id_rsa"
    #config.ssh.forward_agent = true

    #config.vm.provision "ansible" do |ansible|
    #  #see https://docs.vagrantup.com/v2/provisioning/ansible.html
    #  ansible.playbook = "../../ansible/jenkins-UAT.yml"
    #  ansible.inventory_path = "../../ansible/hosts"
    #  ansible.verbose = "vvvv"
    #  ansible.sudo = true
    #  ansible.host_key_checking = false
    #  ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
    #  # Disable default limit (required with Vagrant 1.5+)
    #  ansible.limit = 'all'
    #end
  end

  config.vm.define :masterLIQ do |vagrant|
    vagrant.vm.hostname = HOSTNAME_02
    vagrant.vm.network :private_network, ip: VAGRANT_NETWORK_IP_02
    vagrant.vm.provider :virtualbox do |vb|
      vb.name = HOSTNAME_02
      vb.customize ["modifyvm", :id, "--memory", "8192"]
    end
    #vagrant.vm.provision "file", source: "../keys/id_rsa", destination: "id_rsa"
    #vagrant.vm.provision "file", source: "../keys/id_rsa.pub", destination: "id_rsa.pub"
    #vagrant.vm.provision "file", source: "../keys/mgr.jenkins.pub", destination: "mgr.jenkins.pub"

    #vagrant.vm.provision :shell, :path => "buildup-CentOS.sh"
    vagrant.vm.provision :shell, :path => "buildup-Ubuntu.sh"

	#See issue vagrant forward port 22 unable to force
	#https://stackoverflow.com/questions/30669183/forwarding-the-ssh-port-fails-when-running-two-vagrant-instances-from-the-same-h
	#vagrant.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", disabled: "true"
	vagrant.vm.network "forwarded_port", guest: 22, host: VAGRANT_SSH_PORT_02, id: 'ssh', auto_correct: "true"
	vagrant.vm.network "forwarded_port", guest: 8380, host: 8381, auto_correct: true
	vagrant.vm.network "forwarded_port", guest: 33224, host: 33224, auto_correct: true
	vagrant.vm.network "forwarded_port", guest: 3141, host: 3141, auto_correct: true

    # Do not use a shared folder. We will fetch sources in other ways.
    # This allows us (eventually) to export the VM and move it around.
    vagrant.vm.synced_folder ".", "/vagrant", disabled: true

    #config.ssh.private_key_path = "../keys/id_rsa"
    #config.ssh.forward_agent = true

    #config.vm.provision "ansible" do |ansible|
    #  #see https://docs.vagrantup.com/v2/provisioning/ansible.html
    #  ansible.playbook = "../../ansible/jenkins-UAT-LIQ.yml"
    #  ansible.inventory_path = "../../ansible/hosts"
    #  ansible.verbose = "vvvv"
    #  ansible.sudo = true
    #  ansible.host_key_checking = false
    #  ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
    #  # Disable default limit (required with Vagrant 1.5+)
    #  ansible.limit = 'all'
    #end
  end
end

#Connect doing
#from outside host
#ssh -p 2233 vagrant@albandri
#from inside host
#ssh -p 22 vagrant@192.168.11.33
