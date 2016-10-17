+++
title = "mysqltuner 工具简介"
date = "2014-11-03"
categories = ["mysql"]
tags = ["mysql"]
+++

github repo: https://github.com/major/mysqltuner-perl

> MySQLTuner is a script written in Perl that allows you to review a MySQL installation quickly and make adjustments to increase performance and stability. The current configuration variables and status data is retrieved and presented in a brief format along with some basic performance suggestions.

## download & install

```bash
wget https://raw.githubusercontent.com/major/MySQLTuner-perl/master/mysqltuner.pl

chmod +x mysqltuner.pl
```

## client config

```bash
cat >~/.my.cnf<<EOF
# configuration for mysqltuner.pl script
# set 600 mode for this file to protect credential 
[client]
user=root
pass=password
EOF

chmod 600 mysqltuner.pl 
```

## Run & check

A example from check on slave output , 

```bash
[root@mysql2 ~]# perl mysqltuner.pl 

 >>  MySQLTuner 1.4.0 - Major Hayden <major@mhtx.net>
 >>  Bug reports, feature requests, and downloads at http://mysqltuner.com/
 >>  Run with '--help' for additional options and output filtering
[OK] Currently running supported MySQL version 5.5.39-MariaDB-log
[OK] Operating on 64-bit architecture

-------- Storage Engine Statistics -------------------------------------------
[--] Status: +ARCHIVE +Aria +BLACKHOLE +CSV +FEDERATED +InnoDB +MRG_MYISAM 
[--] Data in InnoDB tables: 368M (Tables: 135)
[--] Data in PERFORMANCE_SCHEMA tables: 0B (Tables: 17)
[!!] Total fragmented tables: 135

-------- Security Recommendations  -------------------------------------------
[OK] All database users have passwords assigned

-------- Performance Metrics -------------------------------------------------
[--] Up for: 20h 43m 3s (654K q [8.774 qps], 23K conn, TX: 1B, RX: 57M)
[--] Reads / Writes: 87% / 13%
[--] Total buffers: 1.2G global + 2.8M per thread (151 max threads)
[OK] Maximum possible memory usage: 1.6G (81% of installed RAM)
[OK] Slow queries: 0% (0/654K)
[OK] Highest usage of available connections: 46% (70/151)
[OK] Key buffer size / total MyISAM indexes: 128.0M/95.0K
[!!] Query cache efficiency: 15.7% (96K cached / 613K selects)
[!!] Query cache prunes per day: 389912
[OK] Sorts requiring temporary tables: 0% (0 temp sorts / 58K sorts)
[OK] Temporary tables created on disk: 0% (33 on disk / 51K total)
[OK] Thread cache hit rate: 99% (106 created / 23K connections)
[OK] Table cache hit rate: 107% (253 open / 236 opened)
[OK] Open file limit used: 5% (58/1K)
[OK] Table locks acquired immediately: 100% (465K immediate / 465K locks)
[OK] InnoDB buffer pool / data size: 1.0G/368.4M
[OK] InnoDB log waits: 0
-------- Recommendations -----------------------------------------------------
General recommendations:
    Run OPTIMIZE TABLE to defragment tables for better performance
    MySQL started within last 24 hours - recommendations may be inaccurate
Variables to adjust:
    query_cache_limit (> 1M, or use smaller result sets)
    query_cache_size (> 32M)

```

## Wrap up

1. 检测结果仅供参考，仔细审核，不要忽视
2. 根据“Variables to adjust”调整参数时，务必先在测试环境验证，或者知道它的“副作用”。比如，`innodb_buffer_pool_size` 官方提供的参考值是系统可用内存的70%-80%，但一般认为占用过多缓存对系统其他进程产生不良影响，谨慎设置在50%，可以在稳定运行一段时间再做调整，另外，过高的buffer pool在mysql启动时需要比较长的预热时间。

