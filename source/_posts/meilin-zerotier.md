---
title: 梅林安装zerotier
date: 2020-01-02 18:50:50
tags: 路由器
---

网件R7000刷梅林, 安装zerotier内网穿透工具, 并配置开机自启

[参考](http://koolshare.cn/forum.php?mod=viewthread&tid=134930&extra=&ordertype=1)

## 安装 entware

```sh
rm -rf /opt

mkdir /opt

cd /opt

wget -O - http://qnapware.zyxmon.org/binaries-armv7/installer/entware_install_arm.sh | sh
```

> 然后会提示你选择哪个分区，选择你挂载的U盘分区

```sh
···省略
Info:  Looking for available partitions...
[1] --> /tmp/mnt/sda1
=>  Please enter partition number or 0 to exit
[0-1]: 1 # 选1回车
···省略
```

> 跑完之后只要不提示错误，就是安装成功了

### 配置entware环境变量

`vim /etc/profile`

直接在前面/usr/sbin:这行下直接添加下面两行并保存退出（ESC+:wq+Enter）

`/opt/bin:/opt/sbin:`

使配置生效

`source /etc/profile`

### 检查entware环境安装情况看是否报错

```sh
opkg update

opkg list
```

## 安装 zerotier

```sh
opkg update

opkg install zerotier
```

## 启动zerotier服务

## 添加端口映射表

## 重启zerotier服务

## 注意事项

1. 安装zerotier之前先安装 entware, 这样才能安装最新版本的zerotier

## 最后

......
