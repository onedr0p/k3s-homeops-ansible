# -*- mode: ruby -*-
# vi: set ft=ruby :

# Specify minimum Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

# Read YAML file with box details
require "yaml"
hosts = YAML.load_file(File.join(File.dirname(__FILE__), "hosts.yml"))

# Set cpus to number of host cpus
cpus = case RbConfig::CONFIG["host_os"]
  when /darwin/ then `sysctl -n hw.ncpu`.to_i
  when /linux/ then `nproc`.to_i
  else 2
end

Vagrant.configure(2) do |config|
  hosts.each do |host|

    # Create vars from box name
    group = host["group"]
    name = host["name"]
    hostname = group+"-"+name
    if Vagrant.has_plugin?("vagrant-vbguest")
      config.vbguest.auto_update = true
      config.vbguest.no_remote = true
      config.vbguest.iso_path = "./VBoxGuestAdditions_6.1.12.iso"
    end

    # Configure host
    config.vm.define hostname do |node|
      node.vm.box = host["box"]
      node.vm.synced_folder ".", "/vagrant", disabled: true
      node.vm.network "private_network", ip: host["ip"]
      node.vm.hostname = hostname
      node.vm.provider "virtualbox" do |vb|
        # vb.linked_clone = true
        # vb.gui = false
        vb.customize [
          "modifyvm", :id,
          "--memory", 1024,
          "--cpus", cpus,
          "--name", hostname,
          "--ioapic", "on",
          "--audio", "none",
          "--uartmode1", "file", File::NULL,
          "--groups", "/"+group,
        ]
        disk = "./"+hostname+"-block.vdi"
        unless File.exist?(disk)
          vb.customize [
            "createhd",
            "--filename", disk,
            "--variant", "Fixed",
            "--size", 512 #MB
          ]
        end
        vb.customize [
          "storageattach", :id,
          "--storagectl", "SCSI",
          "--port", 2,
          "--device", 0,
          "--type", "hdd",
          "--medium", disk
        ]
      end

      # enable ssh two ways :
      # - vagrant ssh
      # - ansible ssh via private key
      node.ssh.config = ".vagrant_ssh_key"
      node.ssh.insert_key = false
      node.ssh.private_key_path = ["~/.vagrant.d/insecure_private_key", "~/.ssh/id_rsa"]
      node.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/authorized_keys"
    end
  end
end
