# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"]
  else
    config.vm.synced_folder ".", "/vagrant"
  end

  config.vm.define "cluster1" do |d|
    d.vm.box = "ubuntu/trusty64"
    d.vm.hostname = "cluster1"
    d.vm.network "private_network", ip: "10.10.10.101"
    d.vm.provider "virtualbox" do |v|
      v.memory = 1536
    end
  end
  config.vm.define "cluster2" do |d|
    d.vm.box = "ubuntu/trusty64"
    d.vm.hostname = "cluster2"
    d.vm.network "private_network", ip: "10.10.10.102"
    d.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
  end
  config.vm.define "cluster3" do |d|
    d.vm.box = "ubuntu/trusty64"
    d.vm.hostname = "cluster3"
    d.vm.network "private_network", ip: "10.10.10.103"
    d.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
  end
  config.vm.define "balancer1" do |d|
    d.vm.box = "ubuntu/trusty64"
    d.vm.hostname = "balancer1"
    d.vm.network "private_network", ip: "10.10.10.100"
    d.vm.provider "virtualbox" do |v|
      v.memory = 1524
    end
  end
end
