+++
title = "anbile 学习笔记（一）"
date =  "2016-03-22"
categories = ["ansible", "devops"]
tags = ["python", "ansible", "note"]
+++

[TOC]

# Anbile 学习笔记（一）

## 前言

关于自动化运维的工具，业内已经有许多优秀的开源工具

* puppet
* saltstack
* chef
* ansible

TODO: 比较它们的优缺点

## 安装

* 目前，版本更新周期为4周
* 推荐的安装方式是通过 「pip」

### 安装要求

#### 控制服务器要求

* 控制服务器系统不支持windows
* Python 2.6 或者 2.7

#### 被管理节点要求

* 需要安装 Python 2.4 以上版本
* 若低于 Python 2.5 需要安装 python-simplejson
* 若启用了 selinux,则需要安装 libselinux-python

### 安装步骤
 
通过「pip」安装最新版本（推荐）

```
sudo easy_install pip
sudo pip install ansible
```

## 注意事项

### 关于SSH

SSH 协议的一些问题：

* Ansible 1.3 以及之后的版本默认使用系统自带的 OpenSSH ，它对一些高级的特性提供了支持。
* Enterprise Linux 6 因为 OpenSSH 版本太低，在这些系统上，Ansible 使用的则是一个OpenSSH的Python实现，叫做『paramiko』

支持的请求方式：

* 默认使用 SSH keys（官方倡导这样做）
* 也可以通过增加 `--ask-pass` 选项，使用密码；如果需要`sudo`，则提供`--ask-become-pass`选项

### 关于 Host Key 检查

Ansible 1.2.1 以及之后的版本默认进行 host key 检查；

在这种情况下，系统重装后，`'known_hosts'`被初始化导致需要通过交互式地确认密钥，为了避免这种情况，在 Ansible 配置文件中增加

```
[defaults]
host_key_chekcing = False
``` 



