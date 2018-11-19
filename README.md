# vagrant-openshift-aio

This project aims to provision a RHEL 7.5 virtual machine with OpenShift Enterprise or CentOS 7 with OKD, both all-in-one, using `openshift-ansible` with container storage, router, registry, metrics, logging and no APB by default.

You can change `OPENSHIFT_DEPLOYMENT_TYPE` and `OPENSHIFT_RELEASE` and `MACHINE_IP` in `Vagrantfile` file or use environment varibles. It defaults to `origin`, `v3.10` and `10.20.30.40` respectively, but can be set to `openshift-enterprise`, `v3.11` and any other private IP of your preference that does not conflict with your network.

After `vagrant up` you'll be able to access your OpenShift instance at: `https://master.ocp.10.20.30.40.nip.io:8443` or `https://master.okd.10.20.30.40.nip.io:8443` with `developer:developer`.

> **NOTE:** You can configure your inventory in `ansible/templates/all-in-one.ini` file.

# Steps

1. Set Environment Variables (Optional):

```shell
export OPENSHIFT_DEPLOYMENT_TYPE=openshift-enterprise
export OPENSHIFT_RELEASE=v3.11
export MACHINE_IP=10.10.10.10
```

For **openshift-enterprise**, a few additional steps are required:

2. Build RHEL 7.5 image using packer:

```shell
git clone https://github.com/jairojunior/packer-rhel
cd packer-rhel
# Download rhel-server-7.5-x86_64-dvd.iso
packer build x86_64-vagrant-ocp.qemu.json -var 'rhn_username=user' -var 'rhn_password=password' -var 'pool_id=abcdefgh'
vagrant box add --name rhel-7.5-ocp rhel-7.5-ocp.box
```

3. Set RHN Credentials:

- Create `ansible/vars/credentials.yml` with `ansible-vault` and the following content:

```yaml
rhn_username: user
rhn_password: p@ss
pool_id: pool-id-with-ocp
```

- Create `.vault` with your vault password.

4. `vagrant up`

## Limitations

- Only tested with libvirt.
- A valid subscription is required (for openshift-enterprise).

## TODO

- VirtualBox for OSX users.
- Fully automate image build.