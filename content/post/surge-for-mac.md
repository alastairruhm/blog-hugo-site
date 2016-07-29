+++
title = "surge for mac 使用备忘"
date = "2016-07-29"
tags = ["surge"]
+++

[TOC]


## 和 iOS 版本使用同一个配置文件

关键词： iCloud 同步、软链接

通过给文件创建软链接的方式，可以令 Mac 版和 iOS 版的 Surge 共用同一个文件。这里以 /iCloud Drive/Surge 文件夹中的 Surge.conf 为主题，为其创建软链接

* 确认 Surge iOS 已经启用了 「iCloud Drive Sync」
* Mac 上打开终端窗口，直接复制如下指令

  ```bash
  ln -sfv "/Users/$(whoami)/Library/Mobile Documents/iCloud~run~surge/Documents/Surge.conf" "/Users/$(whoami)/.surge.conf"
  ```


# 参考链接：

* [Surge for Mac 简明指南 — Medium](https://medium.com/@scomper/surge-for-mac-%E7%AE%80%E6%98%8E%E6%8C%87%E5%8D%97-f6f357b8f09c#.nmhj8buqd)









 

