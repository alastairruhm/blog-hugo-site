+++
title = "anbile 学习笔记（二）"
date = "2016-03-23"
categories = ["ansible", "devops"]
tags = ["ansible学习笔记", "ansible"]
series = [ "ansible学习笔记" ]
+++

[TOC]

# Anbile 学习笔记（二）

## Ansible 一些核心概念

![ansible-component](http://7xqakm.com1.z0.glb.clouddn.com/2016-03-24-ansible-component.png)


* Ansible: 核心
* Modules: 包括 Ansible 自带的核心模块及自定义模块
* Plugins: 模块功能的补充，例如连接插件，邮件插件等
* Playbooks: 编排，定义了 Ansible 多任务的编排
* Inventory: Ansible 管理主机的清单

### Inventory

定义基础设施的清单列表，默认存放在 `/etc/ansible/hosts` 文件中，可以有多个，也可以是`Dynamic Inventory`

#### Hosts and Groups

来看一个配置文件的例子。其中，一条记录就是一个 host，`[]`中的就是 group；

```
mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
three.example.com
```

添加多个相似的 hosts

```
[webservers]
www[01:50].example.com

[databases]
db-[a:f].example.com
```

#### Host Variales

为 Playbook 添加可以替换的变量。

```
[atlanta]
host1 http_port=80 maxRequestsPerChild=808
host2 http_port=303 maxRequestsPerChild=909
```

#### Group Variables

与上面类似，不过是应用在整个定义的组

```
[atlanta]
host1
host2

[atlanta:vars]
ntp_server=ntp.atlanta.example.com
proxy=proxy.atlanta.example.com
```

#### Groups of Groups, and Group Variables

嵌套组的定义

```
[atlanta]
host1
host2

[raleigh]
host2
host3

[southeast:children]
atlanta
raleigh

[southeast:vars]
some_server=foo.southeast.example.com
halon_system_timeout=30
self_destruct_countdown=60
escape_pods=2

[usa:children]
southeast
northeast
southwest
northwest
```

#### 如何按功能区分 Host 和 Group 的变量

假设 Inventory 目录是

```
/etc/ansible/hosts
```

如果 host 的名为 'foosball'，且在 `releigh` 和 `webservers` 组，那么变量文件可以这样组织

```
/etc/ansible/group_vars/raleigh # can optionally end in '.yml', '.yaml', or '.json'
/etc/ansible/group_vars/webservers
/etc/ansible/host_vars/foosball
```

更进一步，假设`/etc/ansible/group_vars/raleigh`这个文件内容

```
---
ntp_server: acme.example.org
database_server: storage.example.org
```

还可以分解为

```
/etc/ansible/group_vars/raleigh/db_settings
/etc/ansible/group_vars/raleigh/cluster_settings
```

注意：这个特性要求 Ansible >= 1.4

附：Inventory 有效参数

http://docs.ansible.com/ansible/intro_inventory.html#list-of-behavioral-inventory-parameters


### Dynamic Inventory

区别与基于文本的 Inventory，动态目录的特性提供了从外部获取 inventory 配置的可能性。

目前支持的几个典型 source: [Cobber](http://docs.ansible.com/ansible/intro_dynamic_inventory.html#example-the-cobbler-external-inventory-script), [AWS EC2](http://docs.ansible.com/ansible/intro_dynamic_inventory.html#example-aws-ec2-external-inventory-script), [OpenStack](http://docs.ansible.com/ansible/intro_dynamic_inventory.html#example-openstack-external-inventory-script)。

PS：使用方法在 ansible 仓库的 `contrib/inventory`目录下获取。

另外，静态清单和动态清单可以[混合使用](http://docs.ansible.com/ansible/intro_dynamic_inventory.html#using-inventory-directories-and-multiple-inventory-sources)。



