# Example configutation for a Vagrant LLMP Stack:

## Pre-requisites
You will need:

[VirtualBox](https://www.virtualbox.org/wiki/Downloads)

The packaged configuration will provide you with the following:

- Linux Debian GNU/Linux 8 (jessie)
- Lighttpd latest
- MySQL 5.5
- PHP 7.0.1

## Install Instructions

Run `vagrant plugin install vagrant-vbguest` to install vagrant guest additions

Run `vagrant up`

This will take some time on first-run

Once it's complete, you should be able to see the contents of `html/index.html` at http://127.0.0.1:8888/


## Disclaimer

This has not been extensively tested but works for me. I am no vagrant expert but wanted to share this repo to help others. Please feel free to use as you wish.