# -*- mode: ruby -*-
# vi: set ft=ruby :

hostname = 'wpvagrant'
ipnumber = '192.168.50.33'
devdns   = 'www.wpvagrant.local'
testdns  = 'test.wpvagrant.local'

dir = Dir.pwd
vagrant_dir = File.expand_path(File.dirname(__FILE__)) + "/vagrant"

Vagrant.configure("2") do |config|

  # Store the current version of Vagrant for use in conditionals when dealing
  # with possible backward compatible issues.
  vagrant_version = Vagrant::VERSION.sub(/^v/, '')

  # Configurations from 1.0.x can be placed in Vagrant 1.1.x specs like the following.
  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # Forward Agent
  #
  # Enable agent forwarding on vagrant ssh commands. This allows you to use identities
  # established on the host machine inside the guest. See the manual for ssh-add
  config.ssh.forward_agent = true

  # Default Ubuntu Box
  #
  # This box is provided by Ubuntu vagrantcloud.com and is a nicely sized (332MB)
  # box containing the Ubuntu 14.04 Trusty 64 bit release. Once this box is downloaded
  # to your host computer, it is cached for future use under the specified box name.
  config.vm.box = "ubuntu/trusty64"

  config.vm.hostname = hostname

  # Local Machine Hosts
  if defined? VagrantPlugins::HostsUpdater

    # Parse through the vvv-hosts files in each of the found paths and put the hosts
    # that are found into a single array.
    hosts = []
    hosts << devdns
    hosts << testdns
    # Pass the final hosts array to the hostsupdate plugin so it can perform magic.
    config.hostsupdater.aliases = hosts
  end

  # Default Box IP Address
  config.vm.network :private_network, ip: ipnumber


  # /srv/database/
  config.vm.synced_folder "vagrant/database/", "/srv/database"

  if File.exists?(File.join(vagrant_dir,'database/data/mysql_upgrade_info')) then
    if vagrant_version >= "1.3.0"
      config.vm.synced_folder "vagrant/database/data/", "/var/lib/mysql", :mount_options => [ "dmode=777", "fmode=777" ]
    else
      config.vm.synced_folder "vagrant/database/data/", "/var/lib/mysql", :extra => 'dmode=777,fmode=777'
    end
  end

  # /srv/config/
  config.vm.synced_folder "vagrant/config/", "/srv/config"

  # /srv/log/
  config.vm.synced_folder "vagrant/log/", "/srv/log", :owner => "www-data"


  # /srv/www/
  if vagrant_version >= "1.3.0"
    config.vm.synced_folder "www/", "/srv/www/", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774" ]
  else
    config.vm.synced_folder "www/", "/srv/www/", :owner => "www-data", :extra => 'dmode=775,fmode=774'
  end

  # get dev and test dns names into env
  config.vm.provision "shell", inline: <<-SHELL
    echo -n                              >  /etc/profile.d/vagrantvars.sh
    echo 'export DEVDNS=#{devdns}'        >> /etc/profile.d/vagrantvars.sh
    echo 'export TESTDNS=#{testdns}'        >> /etc/profile.d/vagrantvars.sh
  SHELL



  # Provisioning
  if File.exists?(File.join(vagrant_dir,'provision','provision-pre.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision-pre.sh" )
  end

  # provision.sh or provision-custom.sh
  if File.exists?(File.join(vagrant_dir,'provision','provision-custom.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision-custom.sh" )
  else
    config.vm.provision :shell, :path => File.join( "vagrant/provision", "provision.sh" )
  end

  # provision-post.sh acts as a post-hook to the default provisioning. Anything that should
  if File.exists?(File.join(vagrant_dir,'provision','provision-post.sh')) then
    config.vm.provision :shell, :path => File.join( "provision", "provision-post.sh" )
  end

  # Always start MySQL on boot, even when not running the full provisioner
  if vagrant_version >= "1.6.0"
    config.vm.provision :shell, inline: "sudo service mysql restart", run: "always"
  end

end
