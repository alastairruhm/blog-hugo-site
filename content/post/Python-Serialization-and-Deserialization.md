+++
title = "Python serialization and deserialization"
date = "2016-08-01"
tags = ["Python", "json"]
+++

[TOC]

> 序列化（Serialzation）将对象的状态信息转换为可以存储或传输的形式的过程叫做序列化。反之将读取到的文本信息转换为对象叫做反序列化。

本篇文章介绍]Python下序列化的方法


## 1. json

json 可以转换的 Python 对象是 list, dict

json 模块的主要的4个方法：

* dumps() 直接操作 Python 的数据类型转换成 json 字符串
* loads() 直接将 json 字符串转换为 Python 的数据类型
* dump() 先将 Python 的数据类型转换成 json 字符串，再写入文件
* load() 先从文件中读取 json 字符串，再转换为 Python 数据类型

## 2. pickle

> pickle是Python语言自己的序列化方式，其优点是可以序列化任何Python对象，不仅限于json的list和dict。我们说Python是面向对象语言，万物皆对象，那么对于pickle来说就是Python的万物皆可序列化。这既是它的优点，也是它的缺点，由于pickle是Python自己的序列化方式，它不支持与其他语言的信息交换。json可以跨语言进行信息交换，但是pickle不行，pickle只能在Python语言下进行信息的交换，而且Python的版本不同，对pickle来说可能还会有兼容性的问题。


## 参考链接

* [序列化 - 廖雪峰的官方网站](http://www.liaoxuefeng.com/wiki/001374738125095c955c1e6d8bb493182103fac9270762a000/00138683221577998e407bb309542d9b6a68d9276bc3dbe000#0)

