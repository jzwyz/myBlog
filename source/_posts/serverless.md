---
title: 云函数（serverless）
date: 2020-10-15 14:35:36
tags: serverless
---

Serverless，它是云计算发展过程中出现的一种计算资源的抽象，依赖第三方服务，开发者可以更加专注的开发自己的业务代码，而无需关心底层资源的分配、扩容和部署。

特征

1. 开发者只需要专注于业务，无需关心底层资源的分配、扩容和部署
2. 按需使用和收费
3. 自动扩缩容

[前端福音：Serverless 和 SSR 的天作之合 - 以腾讯云SCF为例](https://serverlesscloud.cn/best-practice/2020-06-10-ssr-yuga)

[BaaS、FaaS、Serverless都是什么馅儿？](https://www.sohu.com/a/198253530_115128)

[Midway Serverless 使用文档 - 阿里开源](https://www.yuque.com/midwayjs/faas)

[精读《Serverless 给前端带来了什么》](https://zhuanlan.zhihu.com/p/58877583)

# 问题

使用mac系统时出现的一个问题

![ ](./WX20201015-145716@2x.png)

按照其提供的[方法](https://github.com/meteor/meteor/issues/8057#issuecomment-261011063)成功解决

```sh
$ echo kern.maxfiles=65536 | sudo tee -a /etc/sysctl.conf
$ echo kern.maxfilesperproc=65536 | sudo tee -a /etc/sysctl.conf
$ sudo sysctl -w kern.maxfiles=65536
$ sudo sysctl -w kern.maxfilesperproc=65536
$ ulimit -n 65536
```

> 仅适用于 `Mac` 系统
