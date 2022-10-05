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
    vmConfig.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = "1024"
    end

    vmConfig.vm.provision :docker

    vmConfig.vm.provision "shell", path: RUNNER_PROVISION_SCRIPT, env: {
      "AUTH_TOKEN" => AUTH_TOKEN,
      "RUNNER_NAME" => "#{BASE_NAME}-1"
    } 

  end

  (1..NODE_COUNT+1).each do |i|
    config.vm.define "#{BASE_NAME}-#{i}" do |vmConfig|
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

      vmConfig.vm.provision "shell", path: RUNNER_PROVISION_SCRIPT, env: {
        "AUTH_TOKEN" => AUTH_TOKEN,
        "RUNNER_NAME" => "#{BASE_NAME}-#{i}"
      } 

    end
  end
end
