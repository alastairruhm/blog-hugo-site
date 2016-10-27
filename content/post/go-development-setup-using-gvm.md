+++
title = "OSX 上使用 gvm 构建 go 开发环境"
date = "2016-10-20"
tags = ["golang", "gvm"]
+++

# OSX 上使用 gvm 构建 go 开发环境

`Go` 1.5 使用 `Go` 1.4 进行构建，`Go` 源码树完全消除所有C的代码。
`gvm` 项目地址：https://github.com/moovweb/gvm

先安装`gvm`

```
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
```

然后安装`Go 1.4`

```
gvm install go1.4
gvm use go1.4
# 这是必须的，要找到 go 指定版本的二进制程序
export GOROOT_BOOTSTRAP=$GOROOT
```

最后安装`Go` 1.5

```
gvm install go1.5
gvm use go1.5
```

执行 `go version` 即可查看到版本号，已经安装并使用了go 1.5


## 参考：

* [用gvm管理Go项目的workspace | Go语言中文网 | Golang中文社区 | Golang中国](http://studygolang.com/articles/4788)
* [Go 语言的包依赖管理 | IO-meter](https://io-meter.com/2014/07/30/go's-package-management/)


