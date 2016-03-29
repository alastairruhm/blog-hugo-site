+++
title = "sshpass 工具简介"
date = "2014-07-28"
categories = ["ssh"]
tags = ["ssh"]
+++

sshpass: 用于非交互的ssh 密码验证
 
ssh登陆不能在命令行中指定密码，也不能以shell中随处可见的，sshpass 的出现，解决了这一问题。它允许你用 -p 参数指定明文密码，然后直接登录远程服务器。 它支持密码从**命令行**，**文件**，**环境变量**中读取

###安装

```
# OSX 
brew install http://git.io/sshpass.rb
```

###参数一览

```
$ sshpass -h
Usage: sshpass [-f|-d|-p|-e] [-hV] command parameters
   -f filename   Take password to use from file
   -d number     Use number as file descriptor for getting password
   -p password   Provide password as argument (security unwise)
   -e            Password is passed as env-var "SSHPASS"
   With no parameters - password will be taken from stdin

   -h            Show help (this screen)
   -V            Print version information
At most one of -f, -d, -p or -e should be used
```

###使用举例

#### 命令行方式

```
$ sshpass -p user_password ssh user_name@192.168.1.2 
```

#### 文件方式

```
$ echo user_password > ~/.ssh/192.168.1.2
$ sshpass -f ~/.ssh/192.168.1.2 ssh user_name@192.168.1.2
```

#### 环境变量

```
$ export SSHPASS="user_password"
$ sshpass -e ssh user_name@192.168.1.2
```

PS: 支持的协议还包括 `scp ` | `sftp`，例：

```
$  sshpass -p 123456 scp /root/abc.sh 192.168.1.15:/root
```



### 常用方式

#### 结合 iTerm2 实现 ssh 自动登录 

假设 ip 为 10.0.0.2，用户为 root，密码为 root.password
1.  创建密码文件

  ```
  $ echo "root.password" > ~/.ssh/10.0.0.2
  ```

2. 配置 iTerm profile

  在选项 Preferences - Profiles - General - Command 中，选择 "Command" ，填入指令

  ```
  /usr/local/bin/sshpass -f "/Users/ruhm/.ssh/10.0.0.2" ssh root@10.0.0.2
  ```

### 问题补充

1. 对于ssh的第一次登陆，会提示：“Are you sure you want to continue connecting (yes/no)”。
  ssh 指令加入 -o StrictHostKeyChecking=no 解决

