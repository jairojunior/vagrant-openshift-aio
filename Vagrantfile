# -*- mode: ruby -*-
# vi: set ft=ruby :

OPENSHIFT_DEPLOYMENT_TYPE = ENV['OPENSHIFT_DEPLOYMENT_TYPE'] || 'openshift-enterprise'
OPENSHIFT_RELEASE = ENV['OPENSHIFT_RELEASE'] || 'v3.11'
MACHINE_IP='10.20.30.40'

Vagrant.configure("2") do |config|

  config.vm.provider :libvirt do |domain|
      domain.memory = 16384
      domain.cpus = 2
  end

  config.vm.provider :libvirt do |libvirt|
    libvirt.storage :file, :size => '40G'
  end

  config.vm.define :ocp_aio do |ocp_aio|
    ocp_aio.vm.network :private_network, :ip => MACHINE_IP
  end

  config.vm.synced_folder ".", "/vagrant", type: "nfs",
      nfs_version: 4,
      nfs_udp: false

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box

    config.cache.synced_folder_opts = {
      type: "nfs",
      nfs_version: 4,
      nfs_udp: false
    }
  end

  if OPENSHIFT_DEPLOYMENT_TYPE == 'openshift-enterprise'
    config.vm.box = "rhel-7.5-ocp"
    hostname = "master-ocp"
    config.vm.hostname = hostname

    config.trigger.before :destroy do |trigger|
      trigger.warn = "Unsubscribing host..."
      trigger.run_remote = {
        inline: "subscription-manager unsubscribe --all && subscription-manager unregister && subscription-manager clean"
      }
    end
  else
    config.vm.box = "centos/7"
    hostname = "master-okd"
    config.vm.hostname = hostname
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/playbooks/main.yml"

    ansible.extra_vars = {
      deployment_type: OPENSHIFT_DEPLOYMENT_TYPE,
      release: OPENSHIFT_RELEASE,
      machine_ip: MACHINE_IP,
      master_route: hostname.gsub('-', '.')
    }

    unless OPENSHIFT_DEPLOYMENT_TYPE == "origin" then ansible.vault_password_file = '.vault' end
  end

  config.vm.provision "shell", path: "scripts/load-container-images.sh", args: [OPENSHIFT_DEPLOYMENT_TYPE, OPENSHIFT_RELEASE]

  config.vm.provision "ansible_local" do |prerequisites|
    prerequisites.provisioning_path = "/usr/share/ansible/openshift-ansible/playbooks/"
    prerequisites.verbose = true
    prerequisites.raw_arguments = ['--limit=""']
    prerequisites.inventory_path = "/etc/ansible/hosts"
    prerequisites.playbook_command = "sudo ANSIBLE_FORCE_COLOR=true ansible-playbook"
    prerequisites.playbook = "prerequisites.yml"
  end

  config.vm.provision "ansible_local" do |deploy_cluster|
    deploy_cluster.provisioning_path = "/usr/share/ansible/openshift-ansible/playbooks/"
    deploy_cluster.verbose = true
    deploy_cluster.raw_arguments = ['--limit=""']
    deploy_cluster.inventory_path = "/etc/ansible/hosts"
    deploy_cluster.playbook_command = "sudo ANSIBLE_FORCE_COLOR=true ansible-playbook"
    deploy_cluster.playbook = "deploy_cluster.yml"
  end

  config.trigger.after :up do |trigger|
    trigger.info = "OpenShift is ready!"
    trigger.run_remote = {
      inline: 'echo "Openshift is available at: https://$1.$2.nip.io:8443" with developer:developer',
      args: [hostname.gsub('-', '.'), MACHINE_IP]
    }
  end

  config.trigger.before :destroy do |trigger|
    trigger.warn = "Saving container images..."
    trigger.run_remote = {
      path: "scripts/save-container-images.sh",
      args: [OPENSHIFT_DEPLOYMENT_TYPE, OPENSHIFT_RELEASE]
    }
  end

end
