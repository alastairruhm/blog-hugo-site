+++
title = "Mutable Default Parameter Values in Python"
date = "2016-07-15"
tags = ["Python"]
+++

[TOC]

当你使用一个「可变」对象作为函数参数的默认值的时候，比如一个 list 对象或者一个 dictionary 对象，很可能在函数被调用时被修改。

来看一个例子：

```python
>>> def function(data=[]):
...     data.append(1)
...     return data
...
>>> function()
[1]
>>> function()
[1, 1]
>>> function()
[1, 1, 1]
```

data 这个 list 对象越来越长，并且，通过检查id，可以看到，函数始终返回相同的对象

```
>>> id(function())
4325470360
>>> id(function())
4325470360
>>> id(function())
4325470360
```

出现这个现象的原因则是，当函数被定义时，一个新的列表就被创建一次，而且同一个列表在每次成功的调用中都被使用。

当函数被定义时，Python的默认参数就被创建一次，而不是每次调用函数的时候创建。所以如果你使用一个可变默认参数并改变了它的值，这将会导致以后对这个函数的调用都会改变这个对象的值。

那么如何修复呢？在每次函数调用中，通过使用None作为默认参数，来创建新的对象，例如


```python
def myfunc(value=None):
    if value is None:
        value = []
    # modify value here
```

参考链接：

* [Common Gotchas — The Hitchhiker's Guide to Python](http://docs.python-guide.org/en/latest/writing/gotchas/#mutable-default-arguments)
* [Default Parameter Values in Python](http://effbot.org/zone/default-values.htm)
* [language design - "Least Astonishment" in Python: The Mutable Default Argument - Stack Overflow](http://stackoverflow.com/questions/1132941/least-astonishment-in-python-the-mutable-default-argument)









 

