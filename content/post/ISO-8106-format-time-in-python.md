+++
title = "python 中关于 ISO 8601 格式的时间处理"
date = "2016-10-10"
tags = ["Python"]
+++

## 问题来源

起因是调用 Openstack Nova API，获取实例的创建时间，返回的时间字符串是类似 `"2016-10-14T06:30:42Z"`这样格式的 ，尝试用 Python built-in 库中的 time 模块解析成 datetime 对象，结果当然是失败了。

现在问题抽象成：如何将形如 `"2016-10-14T06:30:42Z"` 的字符串转换为对应的 Python 的时间对象。

## ISO 8601 

首先需要知道， `"2016-10-14T06:30:42Z"` 是一种国际标准的时间表示法 [ISO 8601](https://zh.wikipedia.org/wiki/ISO_8601)。

其中的两个字符，"T" 是日期和时间的合并表示时，要在时间前面加一大写字母T；"Z" 表示 UTC 时间，如果是地区时间表示，则可以使用 `+hh:mm:ss` 或者 `-hh:mm:ss`，前者表示超前 `UTC` 时间，后者表示滞后 `UTC` 时间。

## Python 程序中如何处理

[dateutil - powerful extensions to datetime](https://dateutil.readthedocs.io/en/stable/index.html) 针对 Python `datetime`标准库做了扩展。其中就提供了处理 ISO 8601 时间的方法。举例：

```
>>> from dateutil.parser import parse
>>> parse("2016-10-14T06:30:42Z")
datetime.datetime(2016, 10, 14, 6, 30, 42, tzinfo=tzutc())
```

更多用法见手册。


## 参考：

* [ISO 8601 - 维基百科，自由的百科全书](https://zh.wikipedia.org/wiki/ISO_8601)
* [Date and Time Formats](https://www.w3.org/TR/NOTE-datetime)
* [Python-基础-时间日期处理小结](http://www.wklken.me/posts/2015/03/03/python-base-datetime.html#_1)
* [dateutil - powerful extensions to datetime — dateutil 2.5.3 documentation](https://dateutil.readthedocs.io/en/stable/index.html)


