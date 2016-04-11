+++
title = "Issue #3"
date = "2016-04-11"
tags = ["webhook", "issue"]
+++

# Issue #3

[TOC]

## 通过 webhook 方式更新 hugo 自托管站点

使用了一段时间的 `hugo`，还是很方便的。通过 `hugo server`直接运行网站而不使用Apache、Nginx，这种方式在 `git` 库更新后不能自动更新 `content` 内容。考虑通过 `webhook`的方式在 git repo 接受 push 之后主动更新。

大致步骤：

1. hugo 整站的文件通过 git 管理（ gitlab/github 平台）
2. 使用 ananh/webhook 项目配置一个webhook监听
3. gitlab/github 项目配置这个webhook地址

参考：

* [通过webhook将Hugo自动部署至GitHub Pages和GitCafe Pages - CoderZh Blog](http://blog.coderzh.com/2015/09/13/use-webhook-automated-deploy-hugo/)
* [GitHub - adnanh/webhook: webhook is a lightweight configurable tool written in Go, that allows you to easily create HTTP endpoints (hooks) on your server, which you can use to execute configured commands.](https://github.com/adnanh/webhook)
* [GitHub - qiniu/webhook: Github.com webhook tools](https://github.com/qiniu/webhook)


