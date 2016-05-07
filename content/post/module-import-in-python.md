+++
title = "Python 中导入模块的方法"
date = "2016-05-04"
tags = ["python", "module"]
+++

# Python 模块导入知识整理

[toc]

## 常规导入 - regular imports

```
# 最常用方式
import sys

# 导入多个包
# 但是Python风格指南建议将每个导入语句单独成行。
import os, sys, time

# 重命名
import simplejson as json

# 子模块
import urllib.error
```

## 使用 from 语句导入 - from sentence

```
# 这样导入可以直接调用 listdir 函数
from os import listdir

# 导入模块的全部内容
# 会捣乱命名空间，不推荐
from os import *

# 导入多个项
from os import path, walk, listdir \
                remove
```

## 相对导入

[PEP 328](https://www.python.org/dev/peps/pep-0328/) 介绍了引入相对导入的原因以及语法。**使用句点来决定决定如何相对导入其他包或模块。** 这么做的原因是为了避免偶然情况下导入标准库中的模块产生冲突。

```
my_package/ 
    __init__.py 
    subpackage1/ 
        __init__.py 
        module_x.py 
        module_y.py 
    subpackage2/ 
        __init__.py 
        module_z.py 
    module_a.py
```

## 可选导入（Optional imports）

如果你希望优先使用某个模块或包，但是同时也想在没有这个模块或包的情况下有备选，你就可以使用可选导入这种方式。这样做可以导入支持某个软件的多种版本或者实现性能提升。

```
try:
    # For Python 3
    from http.client import responses
except ImportError:# For Python 2.5-2.7
    try:
        from httplib import responses# NOQA
except ImportError:# For Python 2.4 
    from BaseHTTPServer import BaseHTTPRequestHandler as _BHRH
    responses=dict([(k,v[0])fork,vin_BHRH.responses.items()])
```

```
try:
    from urlparse import urljoin
    from urllib2 import urlopen
exceptImportError:
    # Python 3
    from urllib.parse import urljoin 
    from urllib.request import urlopen
```

## 局部导入

当你在局部作用域中导入模块时，你执行的就是局部导入。如果你在Python脚本文件的顶部导入一个模块，那么你就是在将该模块导入至全局作用域，这意味着之后的任何函数或方法都可能访问该模块。例如： 

```
import sys  # global scope

def square_root(a):
    # This import is into the square_root functions local scope
    import math
    return math.sqrt(a)
```








