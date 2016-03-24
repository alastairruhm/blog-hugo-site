+++
title =  "yum 安装指定版本的包"
date = "2016-03-03"
categories = ["yum"]
tags = ["centOS", "yum"]
+++

yum 安装一般是安装当前最新的包，如果想要安装旧版本，则需要一些技巧，以下记录备忘

通过 `--showduplicates` 参数列出安装包不同版本

```
$ yum --showduplicates list filebeat | expand
已加载插件：fastestmirror
Loading mirror speeds from cached hostfile
可安装的软件包
filebeat.x86_64                       1.0.0-1                       elasticstack
filebeat.x86_64                       1.1.1-1                       elasticstack
```

然后在安装时按如下格式添加版本后

```
yum install <package name>-<version info>
```

比如想要安装 filebeat 的 1.0.0-1 版本

```
$ yum install filebeat-1.0.0-1
正在解决依赖关系
--> 正在检查事务
---> 软件包 filebeat.x86_64.0.1.0.0-1 将被 安装
......
```


参考：

* [How can I instruct yum to install a specific version of package X? - Unix & Linux Stack Exchange](http://unix.stackexchange.com/questions/151689/how-can-i-instruct-yum-to-install-a-specific-version-of-package-x)



