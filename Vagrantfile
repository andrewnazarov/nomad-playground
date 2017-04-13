# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
# Update apt and get dependencies
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y unzip curl wget vim

# Download Nomad
echo Fetching Nomad...
cd /tmp/
curl -sSL https://releases.hashicorp.com/nomad/0.5.6/nomad_0.5.6_linux_amd64.zip -o nomad.zip

echo Installing Nomad...
unzip nomad.zip
sudo chmod +x nomad
sudo mv nomad /usr/bin/nomad

sudo mkdir -p /etc/nomad.d
sudo chmod a+w /etc/nomad.d

# Install Consul
echo Fetching Consul...
cd /tmp/
curl -sSL https://releases.hashicorp.com/consul/0.8.0/consul_0.8.0_linux_amd64.zip -o consul.zip
echo Installing Consul...
unzip consul.zip
rm -f consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin/consul
sudo mkdir /etc/consul.d
sudo chmod a+w /etc/consul.d
SCRIPT

#server.vm.provision "shell", inline: <<-SHELL
#          sudo apt-get update
#          sudo apt-get install -y git python-pip python-dev
#          sudo pip install ansible
#        SHELL

Vagrant.configure(2) do |config|

    # Basic configuration
    config.vm.box = "ubuntu/trusty64"
    if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
      config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"]
    else
      config.vm.synced_folder ".", "/vagrant"
    end

    # Provisioners
    #config.vm.provision "shell", inline: $script
    #config.vm.provision "ansible" do |ansible|
    #  ansible.playbook = "ansible/site.yml"
    #  ansible.sudo = "true"
   # end

    # Servers
    1.upto(1) do |i|
      vmName = "nomad-server#{i}"
      vmIP = "10.100.200.1#{i}"
      config.vm.define vmName do |server|
        #server.vm.box = "ubuntu/trusty64"
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
        #node.vm.box = "ubuntu/trusty64"
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
