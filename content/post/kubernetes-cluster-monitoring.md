# kubernetes 集群监控方案研究


* [kubernetes 集群监控方案研究](#kubernetes-%E9%9B%86%E7%BE%A4%E7%9B%91%E6%8E%A7%E6%96%B9%E6%A1%88%E7%A0%94%E7%A9%B6)
  * [kubernetes 时代的监控新的特点](#kubernetes-%E6%97%B6%E4%BB%A3%E7%9A%84%E7%9B%91%E6%8E%A7%E6%96%B0%E7%9A%84%E7%89%B9%E7%82%B9)
  * [kubernetes 系统中有哪些指标需要监控](#kubernetes-%E7%B3%BB%E7%BB%9F%E4%B8%AD%E6%9C%89%E5%93%AA%E4%BA%9B%E6%8C%87%E6%A0%87%E9%9C%80%E8%A6%81%E7%9B%91%E6%8E%A7)
  * [既有方案比较](#%E6%97%A2%E6%9C%89%E6%96%B9%E6%A1%88%E6%AF%94%E8%BE%83)
        * [方案一：Heapster \+ influxDB \+ Grafana](#%E6%96%B9%E6%A1%88%E4%B8%80heapster--influxdb--grafana)
        * [方案二：prometheus \+ (\*)\-exporter \+ Grafana](#%E6%96%B9%E6%A1%88%E4%BA%8Cprometheus---exporter--grafana)
  * [参考资料](#%E5%8F%82%E8%80%83%E8%B5%84%E6%96%99)


## kubernetes 时代的监控新的特点

监控 kubernetes 和传统监控上的一些差异

- Tags 和 labels 变得非常重要；在 kubernetes 系统中，labels 是识别 pods 和 containers 的唯一方式
- 与传统VM监控相比，有更多的组件需要监控: 宿主机器, 容器, 容器化的应用和 kubernetes 本身
- 容器在 kubernetes 中可能发生移动;因此需要监控系统提供服务发现的功能，检测任何来自 pod 和 容器配置的变化，自动适配监控指标的收集，以便持续的监控容器化的应用
- 适应分布式集群监控的特点

## kubernetes 系统中有哪些指标需要监控

- 通常的资源指标，如CPU，内存使用量和磁盘IO
- kubernetes 各逻辑对象的状态，比如 pod 状态，deployment 更新的次数等
- 容器的原生监控指标
- 应用程序监控指标

## 既有方案比较

### 方案一：Heapster + influxDB + Grafana

首先这里的 Heapster 是什么？

Kubernetes有个出名的监控agent---cAdvisor。在每个kubernetes Node上都会运行cAdvisor，它会收集本机以及容器的监控数据(cpu,memory,filesystem,network,uptime)。在较新的版本中，K8S已经将cAdvisor功能集成到kubelet组件中。每个Node节点可以直接进行web访问。

Heapster是一个收集者，将每个Node上的cAdvisor的数据进行汇总，然后导到第三方工具(如InfluxDB)。

该方案的优点是 `heapster` 是 K8s 体系原生的，不需要太多复杂配置就可以完成监控；但是反面来说，`heapster` 局限于 kubernetes 的监控，而不是出于通用监控的目的，另外，heapster 缺少 alert 组件。


### 方案二：prometheus + (*)-exporter + Grafana

之前我分享过 prometheus 是基于 pull 模型的监控系统，那为什么在 Kubernetes 系统的监控中是一个合理的选择，这里有几点

1. kubernetes 原生支持 prometheus：apiserver 服务的 `http://master_ip:8080/metrics` endpoint 将集群中的监控数据暴露出来，prometheus 可以通过 pull 获取
2. cAdvisor 原生支持 prometheus：cAdvisor 已经集成在 kubelet 服务中，prometheus 可以从 `http://node_ip:4194/metrics` 获取监控数据
3. prometheus 通过配置 <kubernetes_sd_configs>，支持将 kubernetes 作为一种服务发现机制
4. kubernetes 可以通过 daemonset 这种资源类型来部署 `node-exporter`，收集每个 node 通用的资源指标，如CPU，内存使用量和磁盘IO
5. kube-state-metrics: kubernetes 各逻辑对象的状态，比如 pod 状态，deployment 更新的次数等5、
6. 应用的监控则可以通过在 Pod 部署时加入相应类型的 exporter 容器来向容器外暴露监控指标，比如在一个运行 mongodb 的 pod 中，加入一个 `mongo_exporter`暴露mongodb的监控指标给 prometheus

这套方案的优点则是 Prometheus 是一个通用的监控系统，可以自由扩展，并且拥有 alertmanager 这样的功能完整的告警组件；而在 pod 中加入一个新的容器来向外暴露监控指标的部署方式又和 k8s 结合的很好。

## 参考资料

- [Kubernetes: Kubernetes: a monitoring guide](http://blog.kubernetes.io/2017/05/kubernetes-monitoring-guide.html)
- datadog 系列文章
    1. [Monitoring in the Kubernetes era](https://www.datadoghq.com/blog/monitoring-kubernetes-era/)
    2. [Monitoring Kubernetes performance metrics](https://www.datadoghq.com/blog/monitoring-kubernetes-performance-metrics/#correlate-with-events)
    3. [How to collect and graph Kubernetes metrics](https://www.datadoghq.com/blog/how-to-collect-and-graph-kubernetes-metrics/#adding-kube-state-metrics)
- [Kubernetes监控之Heapster介绍 - DockOne.io](http://dockone.io/article/1881)
- [Monitoring Kubernetes with Prometheus (Kubernetes Ireland, 2016)](https://www.slideshare.net/brianbrazil/monitoring-kubernetes-with-prometheus-kubernetes-ireland-2016)


