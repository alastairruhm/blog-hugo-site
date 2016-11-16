+++
title = "[openstack] openstacksdk 项目从 0.9.1 升级到 0.9.2 compute 服务返回 404 的问题"
date = "2016-08-23"
tags = ["openstack"]
+++

# openstacksdk 项目从 0.9.1 升级到 0.9.2 compute 服务返回 404 的问题

[openstack/python-openstacksdk: Unified SDK for OpenStack. See: https://wiki.openstack.org/wiki/UnifiedSDK](https://github.com/openstack/python-openstacksdk)


经过调查发现

0.9.1 compute 服务http请求如下：

```
http://10.34.1.10:8774/v2/ab76b9c39d674a2bb1671637af39c529/flavors/detail
```

其中 service endpoint url 

```
http://10.34.1.10:8774/v2/ab76b9c39d674a2bb1671637af39c529
```

而 0.9.2 compute 服务 http 请求如下：

```
http://10.34.1.10:8774/v2/flavors/detail
```

服务端无法处理该请求

----

结论：拥有多个可用域的服务，比如 compute 服务，需要完整的带有id的 service url；

```
http://10.34.1.10:8774/v2/ab76b9c39d674a2bb1671637af39c529
```


而 image、network 服务等则不需要id，url 只有 host 和 port

```
http://10.34.1.10:9292/v2
```


