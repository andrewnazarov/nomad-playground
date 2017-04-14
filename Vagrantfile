# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

    # Basic configuration
    config.vm.box = "ubuntu/trusty64"
    if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
      config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"]
    else
      config.vm.synced_folder ".", "/vagrant"
    end

    # Servers
    1.upto(1) do |i|
      vmName = "nomad-server#{i}"
      vmIP = "10.100.200.1#{i}"
      config.vm.define vmName do |server|
        server.vm.hostname = vmName
        server.vm.network "private_network", ip: vmIP
        server.vm.provider "virtualbox" do |v|
          v.memory = 256
        end
        server.vm.provision "ansible" do |ansible|
          ansible.playbook = "ansible/site.yml"
          ansible.sudo = "true"
        end
      end
    end

    # Clients
    1.upto(2) do |i|
      vmName = "nomad-client#{i}"
      vmIP = "10.100.200.10#{i}"
      config.vm.define vmName do |node|
        node.vm.hostname = vmName
        node.vm.network "private_network", ip: vmIP
        node.vm.provider "virtualbox" do |v|
          v.memory = 384
        end
        node.vm.provision "ansible" do |ansible|
          ansible.playbook = "ansible/site.yml"
          ansible.sudo = "true"
        end
      end
    end
   
end
