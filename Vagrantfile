# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

HOSTNAME = "master"
VAGRANT_BASE_PORT = "33"
VAGRANT_SSH_PORT = "22" + VAGRANT_BASE_PORT
VAGRANT_NETWORK_IP = "192.168.11." + VAGRANT_BASE_PORT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # required to download the box if used for the first time
  # vagrant box add ubuntu14 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box
  config.vm.box = "ubuntu_trusty_x64"
  config.vm.boot_timeout = 600

  config.vm.define :master do |master|
    master.vm.hostname = HOSTNAME
    master.vm.network :private_network, ip: VAGRANT_NETWORK_IP
    master.vm.provider :virtualbox do |vb|
      vb.name = HOSTNAME
      vb.customize ["modifyvm", :id, "--memory", "8192"]
    end
    #master.vm.provision "file", source: "../keys/id_rsa", destination: "id_rsa"
    #master.vm.provision "file", source: "../keys/id_rsa.pub", destination: "id_rsa.pub"

    #master.vm.provision :shell, :path => "buildup.sh"

	#See issue vagrant forward port 22 unable to force
	#https://stackoverflow.com/questions/30669183/forwarding-the-ssh-port-fails-when-running-two-vagrant-instances-from-the-same-h
	#master.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh", disabled: "true"
	master.vm.network "forwarded_port", guest: 22, host: VAGRANT_SSH_PORT, id: 'ssh', auto_correct: "true"
	master.vm.network "forwarded_port", guest: 8380, host: 8380, auto_correct: true
	master.vm.network "forwarded_port", guest: 33224, host: 33224, auto_correct: true
	#master.vm.network "forwarded_port", guest: 3141, host: 3141, auto_correct: true

    # Do not use a shared folder. We will fetch sources in other ways.
    # This allows us (eventually) to export the VM and move it around.
    master.vm.synced_folder ".", "/vagrant", disabled: true

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

end

#Connect doing
#from outside host
#ssh -p 2233 vagrant@albandri
#from inside host
#ssh -p 22 vagrant@192.168.11.33
