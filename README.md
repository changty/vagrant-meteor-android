## Prerequisite
- Virtualbox
- Virtualbox extension pack
- Vagrant (Remeber to run command: vagrant plugin install vagrant-vbguest)
	- Download extension pack from virtualbox.org
	- Run: `$ VBoxManage extpack "path-to-downloaded-extension-pack"`
- SSH command line client (for windows)

## Running meteor project on mobile device via usb
Change the vendorid to match your phone's vendor id. You can find it with command: 

`$ lsusb`


### Setup

`$ cp Vagrantfile.dist Vagrantfile`

`$ vagrant up`

