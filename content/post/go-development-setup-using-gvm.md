+++
title = "macOS 上使用 gvm 创建 golang 开发环境"
date = "2016-10-20"
tags = ["golang", "gvm"]
+++

# macOS 上使用 gvm 创建 Golang 开发环境

[Go 1.8 发布了，又准备尝鲜了](https://blog.golang.org/go1.8)，但是我们不能直接对开发环境升级，毕竟还要工作。这个时候就需要一个 `Go` 版本管理工具 `gvm`。

## 安装

```
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
```

## 安装 Go

由于 1.5 完成了自举，所以编译 1.5 及以上的版本，需要先安装 1.4

```
gvm install go1.4 -B
gvm use go1.4
export GOROOT_BOOTSTRAP=$GOROOT
gvm install go1.8
```

执行 `go version` 即可查看到版本号，已经安装并使用了go 1.8



## 参考：

* [用gvm管理Go项目的workspace | Go语言中文网 | Golang中文社区 | Golang中国](http://studygolang.com/articles/4788)
* [Go 语言的包依赖管理 | IO-meter](https://io-meter.com/2014/07/30/go's-package-management/)
* [tools/godep: dependency tool for go](https://github.com/tools/godep)
* [[go] 使用 gvm 管理 go 版本 - Huang Huang 的博客](https://mozillazg.github.io/2014/12/go-use-gvm-to-manage-go-version.html)