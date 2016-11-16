+++
title = "[Django] How to suppress warnings"
date = "2016-11-16"
tags = ["django"]
+++

# django 关闭兼容性警告信息

最近在使用 django 1.10 版本，在输入管理指令 `python manage.py` 时会出现以下警告信息

```
WARNINGS:
?: (1_10.W001) The MIDDLEWARE_CLASSES setting is deprecated in Django 1.10 and the MIDDLEWARE setting takes precedence. Since you've set MIDDLEWARE, the value of MIDDLEWARE_CLASSES is ignored.
```

如果想要关闭，可以在 `settings.py` 配置文件里加入 `SILENCED_SYSTEM_CHECKS` 这个配置项，例如在这里就可以配置成

```
SILENCED_SYSTEM_CHECKS = ["1_10.W001"]
```

## 参考

* [Settings | Django documentation | Django](https://docs.djangoproject.com/en/1.10/ref/settings/#silenced-system-checks)


