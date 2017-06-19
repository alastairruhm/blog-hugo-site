+++
title = "监控系统 push 和 pull 模型"
date = "2017-06-12"
tags = ["monitor", "监控"]
+++



# 监控系统 push 和 pull 模型

## Push 模型

```
var fooCount = 0

func foo() {
    // ... do stuff ...

    fooCount += 1
    metricsChan <- Metrics{"foo.count", fooCount, CounterType}
}

var metricsChan = make(chan Metrics, 1000)

func metricsPusher() { // run as a goroutine
    for m := range metricsChan {
        // send m to the monitoring system
    }
}
```

push 模型需要处理的一些问题

* Service Discovery: How does the application know where the monitoring system is located? For example, if you are reporting metrics to a StatsD server, all your app instances should know the StatsD server hostname/IP.
* Retry Policy: The sender should have some logic to handle intermittent network disruptions and delays.
* Backlog Management: In the pseudo-code above, the buffered channel had a size of 1000. When dealing with high metric volume, the sender should actively manage this backlog. Cases like production rate higher than dispatch rate, backlog filling up and memory consumption of backlog should be handled.
* Batching: For most systems, it is efficient to batch multiple requests into one, thereby avoiding multiple round trips. The sender should make use of batching if possible.

## Pull 模型

```
import _ "expvar"

var fooCount = expvar.NewInt("foo.count")

func foo() {
    // ... do stuff ...

    fooCount.Add(1)
}

func main() {
    http.ListenAndServe(":8080", nil)
    // http://localhost:8080/debug/vars has the metrics
}

```

pull 模型的一些不同于 push 的特点：


* Lower Application Cost: The cost of memory and CPU at application side is proportional to the number of metrics, not the rate of production of metrics.
* No Application-side Service Discovery: The task of discovering the HTTP endpoints to be monitored is shifted to the monitoring system side.
* Risk of Lost Outliers: If an outlier occurs within two pulls, it will be missed by the monitoring system.
* **No Events**: Typically, it is not possible to report one-shot events (like a “reload” or “deploy”) using the pull mechanism.

## 两类模型的代表

* prometheus 是典型的基于 pull 模型的监控系统，但是它也可以通过 pushgateway 组件支持 push 模型
* StatsD has mostly become the defacto standard for the push method of reporting metrics.
* **Golang 标准库中的 expvar 包常用来暴露 app 中的 metrics**

## furthur reading

* [Go App Monitoring: expvar, Prometheus and StatsD - OpsDash](https://www.opsdash.com/blog/golang-app-monitoring-statsd-expvar-prometheus.html)


