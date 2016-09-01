+++
title = "Python Snippet"
date = "2016-08-31"
tags = ["Python"]
+++
 

## 同时调用多个对象的同一个方法

如果使用for循环，是串行的，效率不高。
如果直接使用map，则需要新写一个函数，调用对象的某个方法，如下的方式不需要新增这个函数。

```python
import operator
def refresh_conn_infos(block_device_mapping, *refresh_args, **refresh_kwargs):
    map(operator.methodcaller('refresh_connection_info',
                              *refresh_args, **refresh_kwargs),
        block_device_mapping)
    return block_device_mapping
```

[*] source: [python代码片段 | 技术人生](http://lingxiankong.github.io/blog/2014/08/16/python-code/)

