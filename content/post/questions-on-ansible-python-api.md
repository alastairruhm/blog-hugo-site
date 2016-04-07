+++
title = "关于 ansible python API 使用的一些问题"
date = "2016-04-06"
categories = ["ansible"]
tags = ["ansible", "devops"]
+++

# 关于 ansible python API 使用的一些问题

## 1. 文档不完善

目前官方的文档就只有一个例子：

> http://docs.ansible.com/ansible/developing_api.html

这样造成的影响就是通过查文档来调用 API 是不现实的，所幸 ansible 代码结构简单，有什么问题直接去查代码就好，顺便可以学习 CLI 指令如何利用 Python API 的。

## 2. 如何查询一个任务的执行状态

检索官方库的 `ansible.plugins.callback` [模块](https://github.com/ansible/ansible/blob/devel/lib%2Fansible%2Fplugins%2Fcallback%2F__init__.py)，或者检索 suitable 项目的 [callback.py](https://github.com/seantis/suitable/blob/master/suitable%2Fcallback.py) 文件

## 3. 如何记录一个task起始时间

📋️ 待解决 @2016-04-06 16:27:27

## 4. 可参考的完整项目列表


* 官方 `repo`
地址：https://github.com/ansible/ansible

* 官方API的wrapper封装，当前版本0.7.3，支持 ansible 2.0及以上版本
地址：https://github.com/seantis/suitable
文档：http://suitable.readthedocs.org/en/latest/

* 基于ansible的异步任务系统 web app
地址：https://github.com/huoxy/farmer

