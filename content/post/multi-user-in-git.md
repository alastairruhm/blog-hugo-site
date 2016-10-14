+++
title = "git 多账号处理"
date = "2016-08-11"
tags = ["git"]
+++

[TOC]

主要分两种场景

## 1. 不同网站的2个git账号使用相同的邮箱

对于不同网站，可以使用同一个邮箱，比如，github，coding的账号可以都是 xxxx#gmail.com，这个时候由于唯一性的认证是邮箱，所以 ssh config 的配置如下

```
host github
  hostname github.com
host coding
  hostname coding.net
```

假设都是默认使用的 id_rsa ，不需要指定key的位置。

## 2. 同一个网站有2个账号

比如有两个github账号

```
host github.com-userA
    hostname github.com
    User userA
    IdentityFile ~/.ssh/github_userA_rsa

host github.com-userB
    hostname github.com
    User userB
    IdentityFile ~/.ssh/github_userB_rsa
    
```

这种情况在 push/pull 的时候要注意取消 global 的账户配置

```
1.取消global的配置
git config --global --unset user.name
git config --global --unset user.email

2.设置每个项目repo的git的user.email, 比如
git config  user.email "userA@xx.com"
git config  user.name "userA"
```

## 如何验证

通过指令 `ssh -T`, 需要详细信息则 `ssh -vT`

```
# ssh -T git@github.com
ssh -T Hi alastairruhm! You've successfully authenticated, but GitHub does not provide shell access.
# ssh -T git@git.coding.net
Hello ruhm! You've connected to Coding.net via SSH successfully!
```

## Q&A

1. 如果发现 push 提交的 user.name 是错误的，如何修复？

    参考：[Changing author info - User Documentation](https://help.github.com/articles/changing-author-info/)

2. 过多的秘钥导致服务器触发最大认证次数而登录失败的问题

    ```
    debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password
    debug1: Next authentication method: publickey
    debug1: Offering RSA public key: /Users/leon/.ssh/id_rsa
    debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password
    debug1: Offering RSA public key: /Users/leon/.ssh/gitcafe_ras
    debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password
    debug1: Offering RSA public key: /Users/leon/.ssh/github_rsa
    debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password
    debug1: Offering RSA public key: /Users/leon/.ssh/zijin-root-server
    debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password
    debug1: Offering RSA public key: /Users/leon/.ssh/gitlab_rsa
    debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic,password
    debug1: Offering RSA public key: /Users/leon/.ssh/github_alastairruhm_rsa
    Received disconnect from 10.34.50.193: 2: Too many authentication failures for root
    Disconnected from 10.34.50.193
    ```
    
    这个时候，先查看系统 ssh-key 代理
    
    ```
    ssh-add -l
    2048 SHA256:xxxx /Users/leon/.ssh/id_rsa (RSA)
    2048 SHA256:xxxx /Users/leon/.ssh/gitcafe_ras (RSA)
    4096 SHA256:xxxx /Users/leon/.ssh/github_rsa (RSA)
    2048 SHA256:xxxx /Users/leon/.ssh/zj-root-server (RSA)
    4096 SHA256:xxxx /Users/leon/.ssh/gitlab_rsa (RSA)
    2048 SHA256:xxxx /Users/leon/.ssh/github_alastairruhm_rsa (RSA)
    2048 SHA256:xxxx /Users/leon/.ssh/google_compute_engine (RSA)
    ```
    
    删除全部代理
    
    ```
    ssh-add -D
    ```
    
    如果是OSX，再通过将私钥加入agent管理
    
    ```
    ssh-add -K /Users/leon/.ssh/google_compute_engine
    ...
    ```
    
    




## 参考链接：

* [Git的多账号如何处理？ 1.同一台电脑多个git（不同网站的）账号 2.同一台电脑多个git（同一个网站的比如github的）多个账号](https://gist.github.com/suziewong/4378434)
* [一个客户端设置多个github账号 - tmyam's blog](http://tmyam.github.io/blog/2014/05/07/duo-githubzhang-hu-she-zhi/)
* [Setting your username in Git - User Documentation](https://help.github.com/articles/setting-your-username-in-git/)
* [my-git/use-gitlab-github-together.md at master · xirong/my-git](https://github.com/xirong/my-git/blob/master/use-gitlab-github-together.md)

