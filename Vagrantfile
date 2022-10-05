# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_IMAGE = 'ubuntu/jammy64'
NODE_COUNT = 1

Vagrant.configure("2") do |config|

  config.vm.define "devops-runner-team-1" do |vmConfig|
    vmConfig.vm.box = BOX_IMAGE
    vmConfig.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = "1024"
    end
    vmConfig.vm.provision :docker
  end

  (1..NODE_COUNT+1).each do |i|
    config.vm.define "devops-runner-team-#{i}" do |vmConfig|
      vmConfig.vm.box = BOX_IMAGE
      vmConfig.vm.provider :virtualbox do |vb|
        vb.gui = false
        vb.memory = "1024"
      end
      vmConfig.vm.provision "shell", 
      inline: <<-SHELL 
      sudo apt update
      sudo apt-get -y install podman
      SHELL
    end
  end
end
