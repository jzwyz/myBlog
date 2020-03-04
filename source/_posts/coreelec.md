---
title: N1安装CoreELEC并安装Docker、Zerotier
date: 2020-03-03 20:37:35
tags: coreelec N1
---

N1安装CoreELEC并安装Docker、Zerotier， 并设置Zerotier开机自启

## 安装CoreELEC

[传送门](https://www.right.com.cn/forum/thread-1135262-1-1.html)

## 安装Docker

直接再CoreELEC的插件库 服务插件中安装即可

### 使用 Portainer 工具管理 Docker

在开发环境下使用此方式合适， 生产环境**不建议**

1. 开启docker api
2. 设置docker镜像源为国内源，（提高下载镜像的速度）

修改启动文件

`vi /storage/.kodi/addons/service.system.docker/system.d/service.system.docker.service`

```sh
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network.target

[Service]
Type=notify
Environment=PATH=/bin:/sbin:/usr/bin:/usr/sbin:/storage/.kodi/addons/service.sys                                      tem.docker/bin
ExecStartPre=/storage/.kodi/addons/service.system.docker/bin/docker-config
EnvironmentFile=-/storage/.kodi/userdata/addon_data/service.system.docker/config                                      /docker.conf
ExecStart=/storage/.kodi/addons/service.system.docker/bin/dockerd -H tcp://0.0.0                                      .0:2375 -H unix:///var/run/docker.sock --registry-mirror=https://el2yu6j2.mirror                                      .aliyuncs.com --exec-opt native.cgroupdriver=systemd --log-driver=journald --gro                                      up=root $DOCKER_DAEMON_OPTS $DOCKER_STORAGE_OPTS
ExecReload=/bin/kill -s HUP $MAINPID
TasksMax=8192
LimitNOFILE=1048576
LimitNPROC=1048576
LimitCORE=infinity
TimeoutStartSec=0
Restart=on-abnormal

[Install]
WantedBy=multi-user.target
Alias=docker.service
```

**注意 ExecStart 这个参数，我遇到的坑，就是这行命令不能换行**

加上 `-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --registry-mirror=https://el2yu6j2.mirror.aliyuncs.com`

重新启动

```sh
$ systemctl daemon-reload
$ systemctl restart docker
```

测试

```sh
$ netstat -anp |grep 2375
```

查看docker是否监听 2375 端口

![ ](./0.png)

## 安装Zerotier

### 安装 ent

### zerotier 开机自启动

zerotier的服务启动文件 `zerotier-one.service`, 放在 `/storage/.config/system.d/` 下面

```sh
[Unit]
Description=zerotier-one                             # 服务名称，不重复就🆗
After=syslog.target network.target

[Service]
Type=forking
PIDFile=/opt/var/lib/zerotier-one/zerotier-one.pid   # 这里按照你的软件安装目录而定
ExecStart=/opt/bin/zerotier-one -d                   # 这里按照你的软件安装目录而定
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true
User=root
Group=root

[Install]
WantedBy=multi-user.target
```

执行命名：

```sh
$ systemctl daemon-reload
$ systemctl restart zerotier-one
$ systemctl enable zerotier-one
```

## 其他
