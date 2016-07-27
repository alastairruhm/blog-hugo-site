+++
title = "integrating saltstack with other services"
date = "2016-07-26"
tags = ["Python", "saltstack"]
+++

[TOC]

最近运维系统项目需要集成 `saltstack` 应用，个人考虑到的实现方式有三种：

# 1. Python client API

官方文档见这里 [Python client API](https://docs.saltstack.com/en/latest/ref/clients/)

优点：
  
  1. 简单易操作，只要机器安装了 saltstack，直接通过应用的Python代码里导入 salt 模块即可

缺点：

  1. Python语言绑定
  2. 应用必须与 salt master 部署在同一台机器上
  3. saltstack任务执行时,某些处理是在调用方进程里执行,这样意味调用方的必须与salt master同用户,否则到时会没有权限往 `/var/cache/salt/master` 目录写缓存文件. 比如salt master是root用户运行,那么django网站调用salt时也必须得也root用户运行.
  
# 2. salt api

官方文档见这里 [netapi modules](https://docs.saltstack.com/en/latest/ref/netapi/all/index.html)

优点:

  1. 通过 `HTTP RESTful API` 方式提供，解除了对客户端语言的限制；
  2. 客户端不需要与 salt master 部署在同一机器;

缺点:

  1. 需要使用者对 RESTful api 做封装，即需要自己实现 SDK；
  2. 部分模块可能需要一些特殊的自定义接口，比如调用 `salt.modules.cp.push` 时
  
# 3. salt command

直接在应用中调用 salt 命令来执行任务，在python中，通常使用 subprocess.popen() 来执行系统指令

优点：

  1. 简单，容易理解，因为通常我们是通过 salt 的命令行工具来学习 saltstack 的

缺点：

  1. 需要精心设计错误处理过程

# 参考链接：

* [rest_cherrypy](https://docs.saltstack.com/en/latest/ref/netapi/all/salt.netapi.rest_cherrypy.html#a-note-about-curl)
* [SaltStack RESTful API的调用[salt-api] | Polar Snow](http://docs.20150509.cn/2016/03/21/SaltStack-RESTful-API%E7%9A%84%E8%B0%83%E7%94%A8-salt-api/)
* https://blog.mangege.com/tech/2015/05/27/1.html
* [Using salt-api to integrate SaltStack with other services | Benjamin Cane](http://bencane.com/2014/07/17/integrating-saltstack-with-other-services-via-salt-api/)









 

