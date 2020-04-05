---
title: clickhouse学习笔记
date: 2019-10-11 10:06:44
tags: 数据库
---

ClickHouse是一个用于联机分析(**OLAP**)的**列式**数据库管理系统(DBMS)。

## Clickhouse使用

[官网](https://clickhouse.yandex/)

[官方文档](https://clickhouse.yandex/docs/zh/)

### 入门(单机)

使用docker部署

```sh
docker pull yandex/clickhouse-server:latest
docker run -d -p 8123:8123 -p 9000:9000 -p 9009:9009 --name clickhouse yandex/clickhouse-server:latest
```

> 其他方式安装参考 [部署运行](https://clickhouse.yandex/docs/zh/getting_started/)

1. 默认没有用户, 设置用户名密码参考 `/etc/clickhouse-server/users.xml` 做添加/修改
2. 默认数据库 `default`
3. 自定义配置文件可以存放在 `/etc/clickhouse-server/config.d` 和 `/etc/clickhouse-server/users.d` 分别对应 系统配置/用户配置, 自动融合到主配置文件中

### 集群

#### 多副本

在 `/etc/clickhouse-server/config.d` 下添加配置文件 `remote_servers.xml`, 例:

```xml
<yandex>
    <remote_servers incl="clickhouse_remote_servers" > <!--集群节点配置-->
        <test_clu> <!-- 集群名称 -->
            <shard> <!-- 分片1 -->
                <internal_replication>false</internal_replication> <!-- 插入数据时,向所有副本插入数据 -->
                <replica> <!-- 副本1 -->
                    <default_database>default</default_database>
                    <host>${host_name}</host> <!--ip-->
                    <port>9000</port>  <!--port-->
                    <user>default</user> <!-- 用户名密码.可选 -->
                    <password>123456</password>
                </replica>
                <replica> <!-- 副本1 -->
                    <default_database>default</default_database>
                    <host>${host_name}</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>123456</password>
                </replica>
             </shard>
         </test_clu>
    </remote_servers>
</yandex>
```

#### 分布式+多副本+高可用 (同步插入)

1. 在 `/etc/clickhouse-server/config.d` 下添加配置文件 `remote_servers.xml`
2. 在 `/etc/clickhouse-server/config.d` 下添加配置文件 `zookeeper.xml`
3. 所有机器都需要创建相同的 `副本表、分布式表`
4. zookeeper 用与分布式协调
5. 分片参数 `internal_replication` 必须设置为 true
6. marcos.xml **每个副本都应该唯一**

sql参考

```sql
--  创建副本表
create table if not exists default.c_user (
    `id` int,
    `name` Nullable(String),
    `sex` int,
    `address` Nullable(String),
    `datetime` Date DEFAULT now()
) ENGINE =MergeTree();

-- 创建分布式表
create table if not exists default.user_all (
    `id` int,
    `name` Nullable(String),
    `sex` int,
    `address` Nullable(String),
    `datetime` Date DEFAULT now()
) engine = Distributed(test_clu, 'default', 'c_user', rand()); -- 集群名称, 数据库, 副本表, 集群数据分配策略
```

`remote_servers.xml` 参考配置

```xml
<yandex>
    <remote_servers incl="clickhouse_remote_servers" >
        <test_clu> <!-- 集群名称 -->
            <shard> <!-- 分片1 -->
                <internal_replication>true</internal_replication> <!-- 插入数据时,向所有副本插入数据 -->
                <replica> <!-- 副本1 -->
                    <default_database>default</default_database>
                    <host>clickhouse_s1</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>123456</password>
                </replica>
                <replica> <!-- 副本2 -->
                    <default_database>default</default_database>
                    <host>clickhouse_s3</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>123456</password>
                </replica>
             </shard>
             <shard> <!-- 分片2 -->
                <internal_replication>true</internal_replication>
                <replica> <!-- 副本1 -->
                    <default_database>default</default_database>
                    <host>clickhouse_s2</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>123456</password>
                </replica>
                <replica> <!-- 副本2 -->
                    <default_database>default</default_database>
                    <host>clickhouse_s4</host>
                    <port>9000</port>
                    <user>default</user>
                    <password>123456</password>
                </replica>
             </shard>
         </test_clu>
    </remote_servers>

    <!-- 数据压缩算法 -->
    <clickhouse_compression>
        <case>
            <min_part_size>10000000000</min_part_size>
            <min_part_size_ratio>0.01</min_part_size_ratio>
            <method>lz4</method>
        </case>
    </clickhouse_compression>
</yandex>
```

`zookeeper.xml` 参考配置

```xml
<yandex>
    <zookeeper incl="zookeeper-servers">
        <node index="1">
            <host>clickhouse_zk0</host>
            <port>2181</port>
        </node>
        <!-- 多节点配置
        <node index="2">
            <host>clickhouse_zk1</host>
            <port>2181</port>
        </node>
        -->
    </zookeeper>
</yandex>
```

#### 分布式+多副本+高可用 (复制表)

上面的基础上再在 `/etc/clickhouse-server/config.d` 下添加配置文件 `macros.xml`

这个方式与上面*同步插入*的区别是 *插入数据时,只向一个副本插入,其他副本自动复制数据*, 我们需要将表引擎由`MergeTree`改为`ReplicatedMergeTree`

参考sql

```sql
--  创建副本表
create table if not exists default.c_user (
    `id` int,
    `name` Nullable(String),
    `sex` int,
    `address` Nullable(String),
    `datetime` Date DEFAULT now()
) ENGINE =ReplicatedMergeTree('/clickhouse/tables/{shard}/default/c_user', '{replica}',`datetime` ,(`datetime`,`id`),8192);
-- {shard} 会自动从 macros.xml 中获取配置
-- {replica} 会自动从 macros.xml 中获取配置
-- `datetime` 是时间类型的字段

-- 创建分布式表
create table if not exists default.user_all (
    `id` int,
    `name` Nullable(String),
    `sex` int,
    `address` Nullable(String),
    `datetime` Date DEFAULT now()
) engine = Distributed(test_clu, 'default', 'c_user', rand());
```

marcos.xml 参考配置

```xml
<yandex>
    <macros replace="replace">
        <shard>SHARD_NAME</shard> <!--集群ID-->
        <replica>REPLICA_NAME</replica> <!--副本ID-->
    </macros>
</yandex>
```

> **每个副本都应该唯一**

## 总结

clickhouse用于大数据查询, 占用空间少, 查询速度快
