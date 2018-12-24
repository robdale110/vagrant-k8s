# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "generic/ubuntu1804"

    # Manager
    config.vm.define "k8s-manager" do |manager|
        manager.vm.network "public_network", bridge: "External Switch"
        #manager.vm.network "forwarded_port", guest: 80, host: 8080
        #manager.vm.synced_folder ".", "/vagrant"
        manager.vm.hostname = "k8s-manager"
        manager.vm.provision "shell", path: "provision/init.sh"
        manager.vm.provision "shell", path: "provision/master.sh"
        manager.vm.provision :reload
       # manager.vm.provision "shell", path: "provision/k8s.sh", :run => "always"
    end    

    # Nodes
    (1..2).each do |number|
        config.vm.define "k8s-node-#{number}" do |node|
            node.vm.network "public_network", bridge: "External Switch"
            node.vm.hostname = "k8s-node-#{number}"
            node.vm.provision "shell", path: "provision/init.sh"
            node.vm.provision "shell", path: "provision/node.sh", args: "#{number}"
            node.vm.provision :reload
        end
    end

    # Provider specific settings
    config.vm.provider :hyperv do |hyperv|
        hyperv.linked_clone = true
        hyperv.cpus = 2
        hyperv.maxmemory = 4096
    end
end
