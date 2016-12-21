+++
title = "给博客添加 https 支持"
date = "2016-12-21"
tags = ["https", "pages"]
+++


事情的起因是 `coding` 更新说`pages`服务支持 https。所以，折腾一番之后，就搞定了。

## coding pages 开启强制 https 访问

按照 [开始使用 Coding Pages-强制 HTTPS 访问](https://coding.net/help/doc/pages/getting-started.html#https-) 开启 Https 访问支持。

PS：这里绑定的 `http`的域名不需要更换为 `https` 的。

## 使用 cloudflare 提供的 SSL 证书

注册 cloudflare 服务。

首先，增加一个`site`配置

![-w487](http://7xqakm.com1.z0.glb.clouddn.com/2016-12-21-14822980860035.jpg)

增加一个 `DNS` 记录，将绑定的域名指向`pages.conding.me` 

![-w499](http://7xqakm.com1.z0.glb.clouddn.com/2016-12-21-14822981467604.jpg)

在 `Crypyo` 配置中 `SSL` 设置为 `Flexible`

![-w490](http://7xqakm.com1.z0.glb.clouddn.com/2016-12-21-14822983519779.jpg)


在 `Page Rule` 中创建一个规则，将 `http` 的请求重定向到 `https`

![-w400](http://7xqakm.com1.z0.glb.clouddn.com/2016-12-21-14822984253436.jpg)



## 将 Nameserver 指向 cloudflare 地址

PS：我这里用的 `Godaddy`，必须去 `Godaddy` 修改

![-w481](http://7xqakm.com1.z0.glb.clouddn.com/2016-12-21-14822982467422.jpg)


## 参考


* [开启 Github Pages 自定义域名 HTTPS 和 HTTP/2 支持​ - 开源小喵Airth的文章 - 知乎专栏](https://zhuanlan.zhihu.com/p/22667528)
* [为绑定域名的 GitHub Pages 启用 HTTPS — 码志](http://mazhuang.org/2016/05/21/enable-https-for-github-pages/)
* [通过HTTPS 访问 github pages | AnnatarHe's blog](https://annatarhe.github.io/2016/03/17/make-github-pages-over-https.html)
* [开始使用 Coding Pages](https://coding.net/help/doc/pages/getting-started.html#https-)
* [Step 3: Change your domain name servers to CloudFlare – Cloudflare Support](https://support.cloudflare.com/hc/en-us/articles/205195708-Step-3-Change-your-domain-name-servers-to-CloudFlare?flash_digest=b9b3aa4d059e124297df532afaebe4f2a1bc454a)


