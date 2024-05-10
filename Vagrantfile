Vagrant.configure("2") do |config|

    ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

    boxes = [
        { :name => "Ubuntu_Server", :box => "Vagrant_Project_M2I/Linux", :ip => "192.168.56.201", :forwarded_port => 2121 },
        { :name => "Windows_Server", :box => "Vagrant_Project_M2I/Windows_Serveur", :ip => "192.168.56.200" },
        { :name => "Kali_Vagrant", :box => "Vagrant_Project_M2I/Kali", :ip => "192.168.56.10", :forwarded_port => 1234 }
    ]

    boxes.each do |box|
        config.vm.define box[:name] do |machines|
            machines.vm.box = box[:box]
            machines.vm.network "private_network", ip: box[:ip]

            if box[:forwarded_port]
                machines.vm.network "forwarded_port", guest: 21, host: box[:forwarded_port]
            end
        end
    end
    config.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 2
    end
end

# Path: Vagrantfile



