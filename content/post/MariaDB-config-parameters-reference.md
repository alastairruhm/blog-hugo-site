+++
title = "MariaDB 配置参数参考"
date = "2014-06-04"
categories = ["mysql"]
tags = ["mysql"]
+++


# mariadb 关键参数配置参考

## `max_connections`
MariaDB 5.5 默认150，取值建议配合线程池的大小适当规划，这个值需要跟`innodb_buffer_pool_size` 关联，至少保证两者相加的内存占用不应该超过OS的可用内存。

* 对于OS 2G memory 建议值不超过256，可以设置为200
* 对于OS 16G memory percona.com 有[文章](https://www.percona.com/blog/2013/11/28/mysql-error-too-many-connections/)建议可以设置为1000或者更多

参考：

* https://www.percona.com/blog/2013/11/28/mysql-error-too-many-connections/
* https://www.percona.com/doc/percona-server/5.5/performance/threadpool.html  Percona从MariaDB引进的线程池特性  
* https://www.percona.com/doc/percona-server/5.5/performance/threadpool.html  MariaDB关于线程池的文档


## `query_cache_size`

**这是一个有些争议的配置项。**

MariaDB官方的文档，
>The query cache stores results of SELECT queries so that if the identical query is received in future, the results can be quickly returned.
>This is extremely useful in high-read, low-write environments (such as most websites).

适合大量读，较少写/更新的典型应用，从反面的理解是高并发，写入更新比较频繁的应用则应该关闭。

在测试过程中发现过高的值会到导致SQL线程出现[`Waiting for query cache lock`](http://dba.stackexchange.com/questions/87287/query-profiling-shows-waiting-for-query-cache-lock-but-query-cache-size-is-0)问题，建议的值为32M，但是在进行性能测试的时候发现如果将这个值设置为0对QPS的提升作用明显。这个可以理解，截取了部分 `sysbench` 只读测试的SQL语句片段，

```sql
SELECT SUM(K) FROM sbtest6 WHERE id BETWEEN 50237 AND 50237+99
SELECT SUM(K) FROM sbtest10 WHERE id BETWEEN 56939 AND 56939+99
SELECT DISTINCT c FROM sbtest6 WHERE id BETWEEN 50021 AND 50021+99 ORDER BY c
SELECT SUM(K) FROM sbtest6 WHERE id BETWEEN 50300 AND 50300+99
SELECT SUM(K) FROM sbtest5 WHERE id BETWEEN 50209 AND 50209+99
SELECT c FROM sbtest1 WHERE id BETWEEN 49667 AND 49667+99 ORDER BY c
SELECT DISTINCT c FROM sbtest8 WHERE id BETWEEN 67634 AND 67634+99 ORDER BY c
SELECT DISTINCT c FROM sbtest3 WHERE id BETWEEN 49920 AND 49920+99 ORDER BY c
SELECT c FROM sbtest3 WHERE id BETWEEN 49572 AND 49572+99 ORDER BY c
SELECT SUM(K) FROM sbtest10 WHERE id BETWEEN 50129 AND 50129+99
```

这些查询几乎都不能命中缓存，所以造成大量SQL线程`Waiting for query cache lock`。

从实际的应用考虑，写操作远远小于读操作，我们可以适量设置这个值为32M或者更多。具体是否启用该选项，**应该等待接入具体的应用性能测试时查看查询的缓存命中率**。

参考：

* http://dba.stackexchange.com/questions/87287/query-profiling-shows-waiting-for-query-cache-lock-but-query-cache-size-is-0
* https://mariadb.com/kb/en/mariadb/query-cache/

一些建议关闭QC的意见：

* http://imysql.com/2015/03/27/mysql-faq-why-should-we-disable-query-cache.shtml
* http://blog.csdn.net/dba_waterbin/article/details/9201645
* http://www.orczhou.com/index.php/2009/08/query-cache-1/

PS：知名的DBA们的意见更倾向于在应用层实现缓存，这个问题需要和应用开发组进行讨论。

## `innodb_buffer_pool_size`

InnoDB用于缓存数据、索引、锁、插入缓冲、数据字典等
如果是专用的DB服务器，且以InnoDB引擎为主的场景，通常可设置物理内存的50%



## `max_connect_errors` 

最大连接错误次数，可适当加大，防止频繁连接错误后，前端host被mysql拒绝掉

通常的配置 `max_connect_errors = 100000`



## 参考

* http://dockone.io/article/1106

