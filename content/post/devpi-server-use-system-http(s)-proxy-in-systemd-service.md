+++
title = "devpi-server 加速内网 pip 安装"
date = "2016-10-04"
tags = ["Python", "devpi"]
+++

## pip 的问题

从 `pypi.python.org` 官方源安装速度太慢，切换到国内的镜像，开发是没有什么问题，但是如果要搞持续集成，就需要在内网构建私有的 pypi 服务来加速安装过程，在搭建私有 pypi 这个问题上，有一堆的工具可以选择，[这篇文章作者做了整理](http://wing2south.com/post/devpi-best-private-pypi-server/)，并且推荐使用 devpi。

## 搭建过程

参考官方提供的安装文档：[Quickstart: running a pypi mirror on your laptop — devpi server-4.0, client-2.6, web-3.1 documentation](http://doc.devpi.net/latest/quickstart-pypimirror.html#installing-devpi-server)，这里不再赘述。

## 客户端配置

创建 `$HOME/.pip/pip.conf` 文件，内容如下

```
[global]
timeout = 60
index-url = http://devpi.xxx.com/root/pypi/+simple/
[install]
trusted-host = devpi.xxx.com
```

PS：如果网络比较差的话，timeout 设置的稍微大一点以免引起安装较大的包时出现 `read timeout` 的问题

## 使用过程中遇到的问题

### devpi-server 配置网络代理

devpi-server [在 v1.2 版本就支持系统的代理配置](http://doc.devpi.net/latest/announce/1.2.html)

> use system http/s proxy settings from devpi-server. fixes issue58.

但是使用的是 systemd 服务配置后台服务的话，proxy 的配置不能写在 `$HOME/.bash_profile` 文件里，要定义在 systemd unit 文件里，看下面的例子

```
[root@devpi ~]# cat /etc/systemd/system/devpi.service
[Unit]
Requires=network-online.target
After=network-online.target

[Service]
Environment=http_proxy=http://proxy.xx.corp.com:1080
Environment=https_proxy=http://proxy.xx.corp.com:1080
Type=forking
PIDFile=/root/.devpi/server/.xproc/devpi-server/xprocess.PID
Restart=always
ExecStart=/usr/bin/devpi-server --host=0.0.0.0 --port 80  --start
ExecStop=/usr/bin/devpi-server --host=0.0.0.0 --port 80 --stop
User=root
```


## 参考：

* [devpi —— 架设私有 pypi 的最佳选择](http://wing2south.com/post/devpi-best-private-pypi-server/)


