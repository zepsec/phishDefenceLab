
Vagrant.configure("2") do |config|
  config.vm.box = "prakharhans/pdc_win7"
  config.vm.box_version = "1.0"
  config.vm.hostname = "pdc_win7_64bit"
  config.vm.network "private_network", type: "dhcp"
  config.vm.communicator = "winrm"
  config.winrm.retry_limit = 1
  config.winrm.retry_delay = 1
  
  config.vm.provider "virtualbox" do |vb|
      vb.name = "Metasploitable3-ub1404"
      vb.memory = 3072
	  vb.cpus = 2
	  vb.gui = true
  end
  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end