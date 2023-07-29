# NixOS System Configurations

Based on [mitchellh/nixos-config](https://github.com/mitchellh/nixos-config) awesome nixos configuration. I will be tailoring it to my needs.

The machine I am using is an intel Macbook Pro 2018 15", so as such I will be removing the machines that mitcheelh has in his configuration and adding my own.
I will be running this VM on [UTM](https://github.com/utmapp/UTM/) checking the 
Apple Virtualization option. This will require me changing the /dev/sda to /dev/vda in the makefile when 
partitioning the disk (I'm not sure why it defaults to /dev/vda but it does).

I removed a bunch of stuff from home-manager - this included the following:
- fish: I always used zsh and I don't like how fish isn't POSIX compliant
- neovim stuff (plugins, treesitter): I prefer using VSCode for my development, and vim for quick edits


I won't be making of Nix Darwin so will be removing the mkdarin.nix file.

# Setup
- Install Nix ISO
- Install UTM `brew install utm`
- Clone this repo
- Create a new VM in UTM with the ISO
- Boot into VM
- ```
$ sudo su
$ passwd
$ change to root
```
- verify that /dev/vda exists `fdisk -l`
- get IP address `ifconfig`
- export NIXADDR in local machine `export NIXADDR=<IP ADDRESS>`
- run `make vm/bootsrap0` in local machine
- Once it reboots, run `make vm/bootstrap` in local machine
- That's it