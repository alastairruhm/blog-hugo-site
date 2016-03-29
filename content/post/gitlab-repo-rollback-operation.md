+++
title = "git 如何回滚已 push 到远程仓库的提交"
date = "2014-06-12"
categories = ["git"]
tags = ["git"]
+++

# 本地回滚

通过 git 日志记录，找到需要回滚到的 commit 的 id，然后使用 reset 指令

``` bash
$ git log
commit d0a91750d63485904f9f8aa821c003ec92cb2483
Author: weixin 
Date:   Thu Jun 11 04:07:56 2015 -0700

    Enhancement of the privileges of staff user or superuser
    
      1. Disallow common users to create libraries and groups
      2. Disallow common users to share the files
      3. All privileges are kept for admin

commit a0ac6faa2cfd8dd0c8b0b4c5d538a8c9e06db385
Author: weixin 
Date:   Tue Jun 9 10:56:23 2015 +0800

    initialization from v4.2.2-server

$ git reset --hard a0ac6faa2cfd8dd0c8b0b4c5d538a8c9e06db385
HEAD is now at a0ac6fa initialization from v4.2.2-server
```

# gitlab 远程仓库回滚

本地回滚完成之后，强制推送本地当前的版本到gitlab远程仓库

```bash
$ git push origin HEAD --force
```

通常对于 master 分支，这样的危险操作会被服务器拒绝，需要在gitlab上将Master分支去掉保护状态。（提交成功之后注意还原）

![master unprotect](http://7sbo6n.com1.z0.glb.clouddn.com/master-brunch-unprotect.png)


提示推送成功，现在代码库就已经完成了回滚

```bash
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.

nothing to commit, working directory clean
```


