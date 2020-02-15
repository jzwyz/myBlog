---
title: StreamSets
date: 2020-02-03 11:08:34
tags: 大数据
---

StreamSets 是我在迁移mysql数据到clickhouse中发现的, 现在来总结一下

Streamsets是一款大数据实时采集和ETL工具，可以实现不写一行代码完成数据的采集和流转。通过拖拽式的可视化界面，实现数据管道(Pipelines)的设计和定时任务调度。最大的特点有：

- 可视化界面操作，不写代码完成数据的采集和流转
- 内置监控，可是实时查看数据流传输的基本信息和数据的质量
- 强大的整合力，对现有常用组件全力支持，包括50种数据源、44种数据操作、46种目的地。

对于Streamsets来说，最重要的概念就是数据源(Origins)、操作(Processors)、目的地(Destinations)。创建一个Pipelines管道配置也基本是这三个方面。

常见的Origins有Kafka、HTTP、UDP、JDBC、HDFS等；Processors可以实现对每个字段的过滤、更改、编码、聚合等操作；Destinations跟Origins差不多，可以写入Kafka、Flume、JDBC、HDFS、Redis等。

## 使用docker创建 StreamSets 实例

```sh
docker run --rm -v /Users/aolei/app/streamsets/sdc-data:/data:rw -v /Users/aolei/app/streamsets/sdc-libs/jdbc:/opt/streamsets-datacollector-3.13.0/streamsets-libs-extras/streamsets-datacollector-jdbc-lib/lib/:rw -p 18630:18630 -d streamsets/datacollector dc
```

## 使用官方核心包运行

[官网](https://streamsets.com/)

[官网下载地址直达](https://streamsets.com/products/dataops-platform/open-source/)

> 下载之前需要填写一些简单的信息

### 配置很简单

保存streamsets的配置 `-v /Users/aolei/app/streamsets/sdc-data:/data:rw`

使用本地的 libs `-v /Users/aolei/app/streamsets/sdc-libs/lib:/opt/ streamsets-datacollector-3.13.0/streamsets-libs/:rw`

## StreamSets 迁移 mysql - clickhouse 使用

### 准备所需的jdbc jar包

如果本地有 maven 环境的, 可以创建一个 `pom.xml` 文件

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.anjia</groupId>
  <artifactId>demo</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>demo</name>
  <url>http://maven.apache.org</url>
  <dependencies>
    <dependency>
        <groupId>ru.yandex.clickhouse</groupId>
        <artifactId>clickhouse-jdbc</artifactId>
        <version>0.1.54</version>
    </dependency>
    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>5.1.47</version>
  </dependency>
  </dependencies>
</project>
```

执行 `mvn dependency:copy-dependencies -DoutputDirectory=lib -DincludeScope=compile` 会在当前目录下生成**lib**文件夹,复制其中的jar包到`/Users/aolei/app/streamsets/sdc-libs/lib`(*你本地映射的streamsets lib目录*)

## 总结

[本文借鉴-简书 北邮郭大宝](https://www.jianshu.com/p/870e1bb52da4)
