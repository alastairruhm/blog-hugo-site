# +++
title = "Issue #6"
date = "2016-06-14"
tags = ["python"]
+++

# Issue #6


## yapf

> YAPF是Google开源的一个工具，可以用来格式化Python代码，使Python代码拥有一致的编程风格，减轻了团队或者个人进行代码风格维护的单调的工作。

### 背景

autopep8的问题：[End the Holy Wars of Formatting | PyTexas 2015](https://www.pytexas.org/2015/talk/13)

### 如何使用

#### 1. 安装

```
pip install yapf
```

#### 2. 使用

命令行参数

```
usage: yapf [-h] [--style STYLE] [-d | -i] [-l START-END | -r] ...

Formatter for Python code.

positional arguments:
  files

optional arguments:
  -h, --help            显示帮助信息
  --style STYLE         指定需要格式化的编程风格，如pep8或者google等
                        也可以是自定义的设置文件。默认是pep8
  -d, --diff            比较格式化后的文件和原文件的区别
  -i, --in-place        直接把格式化的文件更改在源文件上
  -l START-END, --lines START-END
                        指定格式化的行的范围
  -r, --recursive       在目录中递归运行

```


