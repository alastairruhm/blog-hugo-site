
+++
title = "[Django]  MySQL's Strict Mode setting in Django"
date = "2016-08-22"
tags = ["django"]
+++


django 中执行

```
python manage.py migrate
```

时，如果出现以下 告警信息

```
WARNINGS:
?: (mysql.W002) MySQL Strict Mode is not set for database connection 'default'
       	HINT: MySQL's Strict Mode fixes many data integrity problems in MySQL, such as data truncation upon insertion, by escalating warnings into errors. It is strongly recommended you activate it. See: https://docs.djangoproject.com/en/1.10/ref/databases/#mysql-sql-mode
```

需要在 mysql 配置文件中加入

```
[mysqld]
sql_mode='STRICT_TRANS_TABLES'
```

参考：

* https://docs.djangoproject.com/en/1.10/ref/databases/#mysql-sql-mode



