## Vagrant Provisioning for Codiad

This repository holds a simple setup of the Codiad Cloud IDE project.

This will provision an Ubuntu 12.04 (64 bit) server with nginx and php-fpm.

Unless you alter the Vagrantfile, the port will be 8080, meaning the application will be available at:

http://127.0.0.1:8080


When first launching, you'll need to give the username and password.

### Setup

`$ cp Vagrantfile.dist Vagrantfile`

`$ vagrant up`

### Contribute

Raise a PR please ;)
