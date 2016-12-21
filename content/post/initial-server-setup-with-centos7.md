+++
title = "initial Server Setup with CentOS 7"
date = "2016-12-13"
tags = ["cloud", "centos"]
+++

# initial Server Setup with CentOS 7

All commands below has been tested on CentOS 7.2

## Create a New Sudo User

```
# add new user
$ useradd username
# set password 
$ passwd username 


# By default, on CentOS, members of the wheel group have sudo privileges.
$ usermod -aG wheel username
```

## security

### public key authentication

```
$ ssh-keygen
```

In default, will generate a private key `id_rsa` and a public key `id_rsa.pub` in directory `~/.ssh`  

then , copy pubkey to remote server

```
$ ssh-copy-id username@qcloud-cvm-ip
```

### disable root login

```
$ vi /etc/ssh/sshd_config
```

make `PermitRootLogin yes` to `PermitRootLogin no` and restart `ssh`

```
$ systemctl reload sshd
```


## additional steps

### firewall

centos 7 use firewalld service as the default firewall, we can transite it to iptables

```
# install iptables service
$ sudo yum install iptables-services
$ sudo systemctl stop firewalld
$ sudo systemctl disable firewalld

# for iptables
$ sudo systemctl start iptables
$ sudo systemctl enable iptables

# for ip6tables
$ sudo systemctl start ip6tables
$ sudo systemctl enable ip6tables
```

### Configure Timezones

First, take a look at the available timezones by typing:

```
sudo timedatectl list-timezones
```

This will give you a list of the timezones available for your server. When you find the region/timezone setting that is correct for your server, set it by typing:

```
sudo timedatectl set-timezone region/timezone
```

For instance, to set it to United States eastern time, you can type:

```
sudo timedatectl set-timezone Asia/Shanghai
```

Your system will be updated to use the selected timezone. You can confirm this by typing:

```
sudo timedatectl
```

### Configure NTP Synchronization

PS: this step should go after timezone set

```
sudo yum install ntp
sudo systemctl start ntpd
sudo systemctl enable ntpd
```

### Create a Swap File

Adding "swap" to a Linux server allows the system to move the less frequently accessed information of a running program from RAM to a location on disk. Accessing data stored on disk is much slower than accessing RAM, but having swap available can often be the difference between your application staying alive and crashing. This is especially useful if you plan to host any databases on your system.

Advice about the best size for a swap space varies significantly depending on the source consulted. Generally, an amount equal to or double the amount of RAM on your system is a good starting point.

Allocate the space you want to use for your swap file using the fallocate utility. For example, if we need a 4 Gigabyte file, we can create a swap file located at /swapfile by typing:

```
sudo fallocate -l 2G /swapfile
```

After creating the file, we need to restrict access to the file so that other users or processes cannot see what is written there:

```
sudo chmod 600 /swapfile
```

We now have a file with the correct permissions. To tell our system to format the file for swap, we can type:

```
sudo mkswap /swapfile
```

Now, tell the system it can use the swap file by typing:

```
sudo swapon /swapfile
```

Our system is using the swap file for this session, but we need to modify a system file so that our server will do this automatically at boot. You can do this by typing:

```
sudo sh -c 'echo "/swapfile none swap sw 0 0" >> /etc/fstab'
```

With this addition, your system should use your swap file automatically at each boot.


## reference

* [How To Create a Sudo User on CentOS [Quickstart] | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-create-a-sudo-user-on-centos-quickstart)
* [Initial Server Setup with CentOS 7 | DigitalOcean](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-centos-7)
* [How To Migrate from FirewallD to Iptables on CentOS 7 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-migrate-from-firewalld-to-iptables-on-centos-7)


