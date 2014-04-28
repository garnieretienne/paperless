# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :forwarded_port, :guest => 3000, host: 3000

  # Set the VM to 512MB and configure the right number of CPUs
  config.vm.provider "virtualbox" do |v|
    v.memory = 512
    if !RUBY_PLATFORM.downcase.include?("mswin")
      v.customize ["modifyvm", :id, "--ioapic", "on"]
      v.customize ["modifyvm", :id, "--cpus", `grep "^processor" /proc/cpuinfo | wc -l`.chomp ]
    end
  end

  # Enable NFS sharing if env var `PAPERLESS_VAGRANT_ENABLE_NFS` is set to `true`
  if ENV["PAPERLESS_VAGRANT_ENABLE_NFS"] == "true"
    config.vm.network "private_network", :ip => "192.168.10.200"
    config.vm.synced_folder ".", "/vagrant", :type => "nfs"
  else
    config.vm.synced_folder ".", "/vagrant"
  end

  config.vm.provision "shell",
    :path => "bin/vagrant_bootstrap_script",
    :privileged => false
end
