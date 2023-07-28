# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "packer-build-baremetal-ubuntu-22.04.2-amd64"

  config.vm.synced_folder '.', '/vagrant', disabled: false

  config.ssh.username = "ubuntu"
  config.ssh.password = "password"
  config.ssh.dsa_authentication = false
end