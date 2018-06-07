# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Hostmanager vagrant plugin edits /etc/hosts for guest vms.
  # This allows network communication via hostname to work between vms.
  config.hostmanager.enabled = true
  
  # Disable replacing the vagrant insecure private key to be able to
  # use the same key for all hosts
  config.ssh.insert_key = false

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    #vb.gui = true
  
    # Customize the amount of memory on the VM:
    #vb.memory = "1024"
  end

  config.vm.define "tower" do |tower|
    tower.vm.box = "ansible/tower"

    tower.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
    end

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    tower.vm.network "private_network", ip: "172.28.128.6"
    #tower.vm.network "private_network", ip: "10.42.0.42"

    config.vm.provision "shell" do |s|
      ssh_insecure_key = File.read("#{Dir.home}/.vagrant.d/insecure_private_key")
      s.inline = <<-SHELL
        echo "#{ssh_insecure_key}" > /home/vagrant/.ssh/id_rsa
        chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
        chmod 400 /home/vagrant/.ssh/id_rsa
      SHELL
    end
  end

  N = 2
  (1..N).each do |id|
    config.vm.define "host-#{id}" do |host|
      host.vm.box = "centos/7"

      host.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 1
      end

      # Create a private network, which allows host-only access to the machine
      # using a specific IP.
      host.vm.network "private_network", ip: "172.28.128.#{id + 20}"
      #host.vm.network "private_network", ip: "10.42.0.#{id + 50}"
      host.vm.hostname = "host-#{id}"
    end
  end

end
