BOX_IMAGE = 'ubuntu/jammy64'
Vagrant.configure("2") do |config|
  config.vm.define "main" do |ciConfig|
    ciConfig.vm.box = BOX_IMAGE
    ciConfig.vm.hostname = 'vm-test'
    ciConfig.vm.provider :virtualbox do |vb|
      ciConfig.vm.network :private_network, ip: "10.20.1.10"
      vb.gui = false
      vb.memory = "1024"
      vb.cpus = "1"
    end
    ciConfig.vm.provision :docker
  end
end
