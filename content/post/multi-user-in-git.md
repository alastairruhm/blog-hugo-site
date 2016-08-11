+++
title = "git 多账号处理"
date = "2016-08-11"
tags = ["git"]
+++

[TOC]

分两种情况

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

## Q&A

1. 如果发现 push 提交的 user.name 是错误的，如何修复？

  参考：[Changing author info - User Documentation](https://help.github.com/articles/changing-author-info/)




## 参考链接：

* [Git的多账号如何处理？ 1.同一台电脑多个git（不同网站的）账号 2.同一台电脑多个git（同一个网站的比如github的）多个账号](https://gist.github.com/suziewong/4378434)
* [一个客户端设置多个github账号 - tmyam's blog](http://tmyam.github.io/blog/2014/05/07/duo-githubzhang-hu-she-zhi/)
* [Setting your username in Git - User Documentation](https://help.github.com/articles/setting-your-username-in-git/)

