+++
title = "Python 构建 RESTful API 应用相关问题备忘"
date = "2016-08-01"
tags = ["Python", "RESTful"]
+++

[TOC]

## 超文本驱动和资源发现

REST 服务的要求之一就是超文本驱动，客户端不再需要将某些接口的 URI 硬编码在代码中，唯一需要存储的只是 API 的 HOST 地址，能够非常有效的降低客户端与服务端之间的耦合，服务端对 URI 的任何改动都不会影响到客户端的稳定。

目前有几种方案试图实现这个效果：

* [JSON HAL](http://tools.ietf.org/html/draft-kelly-json-hal-07) ，示例可以参考 JSON HAL 作者自己的介绍
* [GitHub API 使用的方案](https://developer.github.com/v3/#hypermedia) ，应该是一种 JSON HAL 的变体
* [JSON API](http://jsonapi.org/) ，（这里有 [中文版](http://jsonapi.org.cn/) ），另外一种类似 JSON HAL 的方案
* [Micro API](http://micro-api.org/) ，一种试图与 JSON-LD 兼容的方案

目前所知的方案都实现了发现资源的功能，服务端同时需要实现 OPTIONS 方法，并在响应中携带 Allow 头来告知客户端当前拥有的操作权限。

PS：JSON API 有一个Python实现，[django-json-api/django-rest-framework-json-api: Implements most of the JSON API 1.0 spec.](https://github.com/django-json-api/django-rest-framework-json-api)

## 文档

[apidoc - RESTful API 文档生成工具](http://apidoc.tools/#docs)
[apiDoc - Inline Documentation for RESTful web APIs](http://apidocjs.com/#param-api-group)

## 参考链接

* [bolasblack/http-api-guide](https://github.com/bolasblack/http-api-guide#user-content-%E6%9B%B4%E7%BB%86%E8%8A%82%E7%9A%84%E6%8E%A5%E5%8F%A3%E8%AE%BE%E8%AE%A1%E6%8C%87%E5%8D%97)


