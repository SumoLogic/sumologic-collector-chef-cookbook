# Vagrant

## Prerequisites

Please install the following:

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)
- [vagrant-disksize](https://github.com/sprotheroe/vagrant-disksize) plugin

### MacOS

```bash
brew cask install virtualbox
brew cask install vagrant
vagrant plugin install vagrant-disksize
```

## Setting up

You can set up the Vagrant environment with just one command:

```bash
vagrant up
```

After successfull installation you can ssh to the virtual machine with:

```bash
vagrant ssh
```

To run test:

```bash
cd /sumologic/sumologic-collector
make test
```

To run example cookbook:

```bash
cd /sumologic/sumologic-collector/vagrant
make run
```

NOTICE: The directory with sumologic-collector-chef-cookbook repository on the host is synced with `/sumologic/sumologic-collector` directory on the virtual machine.
