+++
title = "检索运行中的 galera 节点的 SEQNO"
date = "2016-04-06"
tags = ["mariadb", "galera"]
+++


# FIND GALERA SEQNO/GTID FROM RUNNING NODE

通常情况下，只有合规的服务停止（clean shutdown）才会讲`seqno`字段写入 `grastate.dat` 文件，如果是一个运行中的节点，我们按照下面的办法来找出其`seqno`：

```
MariaDB [(none)]> show status like '%wsrep_last_committed%';
+----------------------+-------+
| Variable_name | Value |
+----------------------+-------+
| wsrep_last_committed | 16 |
+----------------------+-------+
1 row in set (0.01 sec)

```



