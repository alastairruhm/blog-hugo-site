+++
title = "using proxy on git"
date = "2016-11-07"
tags = ["git", "github", "proxy"]
+++

# github 加速

github 访问受限，导致 clone / push 等操作速度很慢。以下是两个加速的方法以及缺陷和对比

## https

github 允许用户通过 `https` 端口使用 `ssh`，可以通过下面的指令测试

```
ssh -T -p 443 git@ssh.github.com
Hi username! You've successfully authenticated, but GitHub does not
provide shell access.
```

如果测试不通过，就需要修改配置文件 `~/.ssh/config`，增加

```
Host github.com
  Hostname ssh.github.com
  Port 443
```

### 优点

* `http` 和 `https` 代理是非常常见的，比如我一般都是对系统全局代理
* 配置比较简单

### 缺点

* 因为走的是 `https` 协议，那么在github认证时只能使用提供 username/password 的方式认证，如果要避免每次push时都输入密码，需要一些额外的步骤。[Caching your GitHub password in Git - User Documentation](https://help.github.com/articles/caching-your-github-password-in-git/)
* 另外如果开启了 `two-factor authentication`，还需要提供 `personal access token`。[Provide access token if 2FA enabled - User Documentation](https://help.github.com/articles/https-cloning-errors/#provide-access-token-if-2fa-enabled)


更多详情参考 [Using SSH over the HTTPS port - User Documentation](https://help.github.com/articles/using-ssh-over-the-https-port/)

## ssh 

前提：需要一个 socks5 代理

如果是直接通过 `ssh` 协议访问，则需要按照以下步骤配置

在 `/usr/local/bin` 增加一个文件，名为 `git-proxy-wrapper`，增加 +x 权限

```
ruhm@mac:~$ cat /usr/local/bin/git-proxy-wrapper
#! /bin/bash
nc -xlocalhost:1080 -X5 $*
```

注意，上面需要本机在 `1080` 端口打开 `socks5` 代理，端口可以自定义

`~/.ssh/config` 配置文件中内容如下

```
Host github.com
    hostname github.com
    User xxxxx
    IdentityFile ~/.ssh/xxxxxx
    ProxyCommand /usr/local/sbin/git-proxy-wrapper '%h %p
```

### 优点

* ssh 认证不需要提供用户名和密码

### 缺点

* 需要一个 `socks5` 代理


## 参考

* [有何方法可以给github远程仓库的push提速？ - 知乎](https://www.zhihu.com/question/23315073)
* [Git and socks5 proxy](https://gist.github.com/goncha/4591538)


