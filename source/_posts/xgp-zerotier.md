---
title: 小钢炮安装zerotier实现内网穿透
date: 2020-01-02 17:54:31
tags: 小钢炮
---

小钢炮安装zerotier实现内网穿透

## 安装zerotier

### 一、安装 entware

为了安装最新版本的zerotier,我们需要先安装 *entware*

执行

```sh
rm -rf /opt

mkdir /opt

cd /opt

wget -O - http://bin.entware.net/aarch64-k3.10/installer/alternative.sh | sh
```

将自带opkg改名为opkg_bak暂时停用 灯大固件更新可以改回来免重装系统更新软件

mv /usr/bin/opkg /usr/bin/opkg_bak

### 二、配置entware环境变量

`vim /etc/profile`

直接在前面/usr/sbin:这行下直接添加下面两行并保存退出（ESC+:wq+Enter）

`/opt/bin:/opt/sbin:`

使配置生效

`source /etc/profile`

### 三、检查entware环境安装情况看是否报错

```sh
opkg update

opkg list
```

### 四、安装zerotier

`opkg install zerotier`

启动zerotier

`zerotier-one -d`

查看服务状态

`zerotier-one info`

## 加入已有zerotier网络

1. 登陆并打开你的zerotier网络管理页面
2. 拷贝你的网络ID

![ ](./CD65E8E75C1CBF3BF60AFBF278909ACD.jpg)

加入网络 `zerotier-cli join <netowkr-id>`

查看网络状态 `zerotier-cli listnetworks`

## 设置开机自启

创建 /etc/init.d/S60zerotier-one.sh 文件

编辑为以下内容

```sh

#! /bin/sh

case "$1" in
  start)
    if ( pidof zerotier-one )
    then echo "ZeroTier-One is already running."
    else
        echo "Starting ZeroTier-One" ;
        /opt/bin/zerotier-one -d ;
        echo "$(date) Started ZeroTier-One" >> /opt/var/log/zerotier-one.log ;
    fi
    ;;
  stop)
    if ( pidof zerotier-one )
    then
        echo "Stopping ZeroTier-One";
        killall zerotier-one
        echo "$(date) Stopped ZeroTier-One" >> /opt/var/log/zerotier-one.log
    else
        echo "ZeroTier-One was not running" ;
    fi
    ;;
  status)
    if ( pidof zerotier-one )
    then echo "ZeroTier-One is running."
    else echo "ZeroTier-One is NOT running"
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/zerotier-one {start|stop|status}"
    exit 1
    ;;
esac

exit 0

```

**授予权限**

`chmod 777 /etc/init.d/S60zerotier-one.sh`

## 结束

完成以上操作即可在小钢炮中安装zerotier并实现开机自启
