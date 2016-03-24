+++
title = "openstack 虚拟机 redis 基本性能测试"
date = "2015-11-07"
categories = ["redis"]
tags = ["redis"]
+++

虚拟机参数  
CPU核数：2U  
内存：4G  
磁盘：rbd-100G  
redis 版本 2.8.19  

工具：使用`redis`自带的`redis-benchmark`程序测试。

* 测试1: 50个 client 同时发起 100000 个请求。默认为10个pipeline

```bash
[root@host-192-168-1-18 ~]# redis-benchmark -q -n 100000 -c 50
PING_INLINE: 120772.95 requests per second
PING_BULK: 128040.97 requests per second
SET: 103199.18 requests per second
GET: 121951.22 requests per second
INCR: 105263.16 requests per second
LPUSH: 124223.60 requests per second
LPOP: 140252.45 requests per second
SADD: 131752.31 requests per second
SPOP: 101522.84 requests per second
LPUSH (needed to benchmark LRANGE): 120627.27 requests per second
LRANGE_100 (first 100 elements): 48473.10 requests per second
LRANGE_300 (first 300 elements): 18907.17 requests per second
LRANGE_500 (first 450 elements): 12655.02 requests per second
LRANGE_600 (first 600 elements): 9638.55 requests per second
MSET (10 keys): 66093.85 requests per second
```
`SET/GET`操作都达到了10w+每秒，对于缓存 http session数据来说，应该有余裕的。此时通过 `glances` 观察系统状态，CPU占用 90%以上，内存占用不到100M。CPU IO成为瓶颈。

* 测试2: 待补充...


