Vagrant.configure("2") do |config|

    ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

    boxes = [
        { :name => "Ubuntu_Server", :box => "Vagrant_Project_M2I/Linux", :ip => "192.168.56.201", :forwarded_port => 2121 },
        { :name => "Windows_Server", :box => "Vagrant_Project_M2I/Windows_Serveur", :ip => "192.168.56.200" }
    ]

    if ENV.has_key?('VAGRANT_BOX') and ENV['VAGRANT_BOX'].include? "kali"
        boxes.append(
            { :name => "Kali_Vagrant", :box => "Vagrant_Project_M2I/Kali", :ip => "192.168.56.10", :forwarded_port => [{:guest => 22, :host => 2210, :id => "ssh"}] 
            }
        )
    end

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
    config.vm.boot_timeout = 600
    config.vm.graceful_halt_timeout = 600
    config.ssh.insert_key = false
    
    config.vm.define "Ubuntu_Server" do |ubuntu|
        ubuntu.vm.provision "shell", inline: <<-SHELL
            Installation des prérequis
            apt-get update
            apt-get upgrade -y
            apt-get install -y vsftpd
            apt-get install -y vsftpd apache2 mariadb-server php libapache2-mod-php php-mysql
            # Configuration de vsftpd
            echo "anonymous_enable=YES" >> /etc/vsftpd.conf
            echo "local_enable=YES" >> /etc/vsftpd.conf
            echo "write_enable=YES" >> /etc/vsftpd.conf
            echo "anon_upload_enable=YES" >> /etc/vsftpd.conf
            echo "anon_mkdir_write_enable=YES" >> /etc/vsftpd.conf
            echo "anon_other_write_enable=YES" >> /etc/vsftpd.conf
            echo "chroot_local_user=YES" >> /etc/vsftpd.conf
            echo "listen=YES" >> /etc/vsftpd.conf
            # Redémarrage du service vsftpd
            service vsftpd restart
            # Configuration de la base de donées GLPI
            mysql -u root -e "CREATE DATABASE glpi;"
            mysql -u root -e "CREATE USER 'glpi'@'localhost' IDENTIFIED BY 'password';"
            mysql -u root -e "GRANT ALL PRIVILEGES ON glpi.* TO 'glpi'@'localhost';"
            mysql -u root -e "FLUSH PRIVILEGES;"
            # Télécharement de GLPI
            wget https://github.com/glpi-project/glpi/releases/download/9.5.5/glpi-9.5.5.tgz
            tar -xvzf glpi-9.5.5.tgz -C /var/www/html/
            chown -R www-data:www-data /var/www/html/glpi
            chmod -R 755 /var/www/html/glpi
            # Configuration d'apache
            echo "<VirtualHost *:80>
                DocumentRoot /var/www/html/glpi
                <Directory /var/www/html/glpi>
                    AllowOverride All
                    Require all granted
                </Directory>
            </VirtualHost>" > /etc/apache2/sites-available/glpi.conf
        
            a2ensite glpi.conf
            a2dissite 000-default.conf
            service apache2 restart
        SHELL
    end

    config.vm.define "Kali_Vagrant" do |kali|
        kali.vm.provision "shell", inline: <<-SHELL

        SHELL
    end
end
