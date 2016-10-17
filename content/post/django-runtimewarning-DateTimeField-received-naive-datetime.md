+++
title = "[Django] RuntimeWarning: DateTimeField received a naive datetime"
date = "2016-08-16"
tags = ["django"]
+++


Django 开发中，在model中定义了一个时间字段

```
...
approved_time = models.DateTimeField(null=True, blank=True)
...
```

赋值时

```python
import datetime
...
application.approved_time = datetime.datetime.now()
...
```

在启动 Django server 时会产生警告

```
RuntimeWarning: DateTimeField Application.approved_time received a naive datetime (2016-08-16 09:08:22.321713) while time zone support is active.
```

解决方法是使用 Django 的 now() 方法

```python
>>> from django.utils import timezon
>>> timezone.now()
datetime.datetime(2016, 8, 16, 1, 26, 31, 56088, tzinfo=<UTC>)
```

对比一下 datetime 模块的 now() 方法

```python
>>> import datetime
>>> datetime.datetime.now()
datetime.datetime(2016, 8, 16, 9, 27, 2, 931554)
```



## 参考

* [django - RuntimeWarning: DateTimeField received a naive datetime - Stack Overflow](http://stackoverflow.com/questions/18622007/runtimewarning-datetimefield-received-a-naive-datetime)



