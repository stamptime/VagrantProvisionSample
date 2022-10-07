# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

RUNNER_PROVISION_SCRIPT = 'https://gist.githubusercontent.com/VallecillaJesus/9d9d641bbb614b5391690dc7f837158d/raw/e16384898934126666a5bd25bd47a1d66a3bc6cb/github-runner.sh'

local_settings = YAML.load_file 'local.yml'
settings = YAML.load_file 'settings.yml'
vm_settings = settings["vm"]

BOX_IMAGE = settings["image"]

NODE_COUNT = vm_settings["amount"]
BASE_NAME = vm_settings["base-name"]

AUTH_TOKEN = local_settings["token"]


Vagrant.configure("2") do |config|

  config.vm.define "#{BASE_NAME}-1" do |vmConfig|
    vmConfig.vm.box = BOX_IMAGE
    vmConfig.vm.hostname = 'vm1'
    vmConfig.vm.network "forwarded_port", guest: 8080, host: 8080
    vmConfig.vm.network "forwarded_port", guest: 8081, host: 8081
    vmConfig.vm.network "forwarded_port", guest: 8082, host: 8082
    vmConfig.vm.network "forwarded_port", guest: 9000, host: 9000
    vmConfig.vm.network "forwarded_port", guest: 8000, host: 8000
    vmConfig.vm.network "forwarded_port", guest: 9443, host: 9443
    
    vmConfig.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = "4096"
      vb.cpus = "2"
    end

    vmConfig.vm.provision "shell", path: RUNNER_PROVISION_SCRIPT, env: {
      "AUTH_TOKEN" => AUTH_TOKEN,
      "RUNNER_NAME" => "#{BASE_NAME}-1"
    } 
    vmConfig.vm.provision :docker
    vmConfig.vm.provision "shell", path: "./launcher.sh"

  end

  (1..NODE_COUNT).each do |i|
    config.vm.define "#{BASE_NAME}-#{i+1}" do |ciConfig|
      ciConfig.vm.box = BOX_IMAGE
      ciConfig.vm.hostname = "vm-#{i}"
      ciConfig.vm.provider :virtualbox do |vb|
        vb.gui = false
        vb.memory = "512"
        vb.cpus = "1"
      end

      ciConfig.vm.provision "shell", path: RUNNER_PROVISION_SCRIPT, env: {
        "AUTH_TOKEN" => AUTH_TOKEN,
        "RUNNER_NAME" => "#{BASE_NAME}-#{i}"
      } 

      ciConfig.vm.provision "shell", 
      inline: <<-SHELL 
      sudo apt-get -y install podman
      SHELL

    end
  end
end
