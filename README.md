# 基于 hexo框架 的个人博客项目

1. Hexo框架的博客
2. 使用 Annie 主题

## 其他说明

1. 使用到的图片资源 由 [Unsplash Source](https://source.unsplash.com) 提供
2. db.json 是 annie 主题使用

## 运行镜像 映射内部4000端口到本机4000端口 使用本机source文件夹作为容器内部/app/source数据卷 --rm参数

```bash
docker run -d -p 4000:4000 --rm -v ~/myWorkspace/myproject/myblog/source:/app/source --name=myblog myblog
```

```bash
docker run -d --rm -v ~/../workspace/my-blog/source:/app/source --network=app-bridge --name=webblog myblog:1.0
```

## github部署

```sh
hexo deploy
```

1. 大的技术栈
2. 前端技术栈
3. 运维部署服务器

2年nodejs全栈开发经验, 熟练掌握基于nodejs微服务框架nestjs开发项目, mysql数据库sql查询优化;
熟练掌握nodejs、es语法规范(es5、es6等)、typescript、nodemon;
熟练掌握nodejs服务端框架,如: express、fastify、koa、websocket、sequelize、typeorm、knex、lodash、moment;
熟练掌握nodejs前端框架,如: reactjs、nextjs、蚂蚁ant系列框架、mobx状态管理等前端框架开发, 熟悉相应的技术语法;
熟练掌握javascript原生语言、jQuery、HTML5、CSS、Ajax;
掌握nodejs微服务框架nestjs、hemera、nats;
掌握mysql数据库基本sql优化, redis缓存技术, clickhouse数据库、;
掌握k8s+dokcer容器化部署、自动运维技术;
掌握linux服务器常用命令及部署运维相关操作;
掌握常用web服务器部署、配置调优,如nginx;
了解 React Native、Flutter等框架

1年java web开发经验, 掌握基于ssh、ssm的java web项目开发;
熟悉 Java SE、Java EE、Android开发
熟练基于SSH、SSM、Spring Boot、Jfinal等主流框架的WEB开发；
熟悉在ssh/ssm框架中融入 Web Service、Shiro等技术；
了解java网络编程、多线程；
熟悉使用nginx、dubbo等分布式集群技术；
熟悉使用Oracle、MySQL、SQL Server等主流数据库；
熟悉了解Redis、MongoDB等NoSQL数据库；
掌握docker+k8s容器化部署、自动运维技术
熟悉使用Ubuntu、CentOS等Linux内核的服务器系统；


### 简化版

两年nodejs全栈开发经验, 熟练使用基于nodejs技术栈开发全栈应用, 在nodejs微服务开发上也有一定的经验.
一年java web项目开发经验, 掌握使用spring全家桶开发web应用的能力.
掌握基本的mysql数据库sql查询优化, 对buy有敏锐的察觉和解决能力


2年nodejs全栈开发经验, 熟练掌握基于nodejs微服务框架nestjs开发项目, mysql数据库sql查询优化;
熟练掌握nodejs、es语法规范(es5、es6等)、typescript、nodemon;
熟练掌握nodejs服务端框架,如: express、fastify、koa、websocket、sequelize、typeorm、knex、lodash、moment;
熟练掌握nodejs前端框架,如: reactjs、nextjs、蚂蚁ant系列框架、mobx状态管理等前端框架开发, 熟悉相应的技术语法;
熟练掌握javascript原生语言、jQuery、HTML5、CSS、Ajax;
掌握nodejs微服务框架nestjs、hemera、nats;
掌握mysql数据库基本sql优化, redis缓存技术, clickhouse数据库、;
掌握k8s+dokcer容器化部署、自动运维技术;
掌握linux服务器常用命令及部署运维相关操作;
掌握常用web服务器部署、配置调优,如nginx;
了解 react native、flutter等框架

1. 2年nodejs全栈开发经验, 熟悉nodejs、es语法规范(es5、es6等)、typescript、nodemon,
   掌握基于nodejs微服务框架nestjs开发项目,mysql数据库sql查询优化.
2. 基于nest搭配graphql实现“彩站帮帮”项目后台服务, 采用passport+jwt+cookie实现前后端分离用户登陆认证授权,
   websocket后台服务主动推送消息给前端实现平台消息通知, 内部服务主要由express实现, 使用typeorm数据库连接,
   接口参数验证采用class-validator框架组, 定时任务框架nest-schedule, 其他框架包含loadsh、moment、ioredis.
3. 采用next+reactjs+ant-mobile技术实现移动H5页面+混合android应用程序, 通过graphql与后端数据交互, cookies保存用户登陆数据,
   reacjs状态管理机制mobx实现, 实现“彩站帮帮”前端H5,整体坚持组件化开发减少代码冗余.
4. 以Fastify WEB服务框架, sequelize、knex数据库连接框架, 实现“一定牛”系列项目的微服务开发, 基于nats、hemera实现微服务注册、通讯,
   mysql作为常备数据库使用, 大量老数据、热点查询数据使用clickhouse数据库实现快速查询.
   项目后台系统基于蚂蚁金服开源框架ant系列 + reactjs组件化搭建, mobx实现reactjs状态更新, session保存用户登陆状态.
5. 其他的项目, 主要以express WEB服务框架+ejs实现服务端渲染, 数据库及ORM框架依旧基于mysql+sequlize+redis+mongodb,
   前端页面基于HTML、jQuery、CSS、bootstrap、ejs模版实现, 前后端交互基于graphql, cookies保存用户登陆信息.
6. 项目运维部署的方式,采用了k8s+docker容器化自动运维部署, 通过编写Dockerfile实现, 基于腾讯云平台.
7. 容器内部基于k8s负载均衡, 对外服务采用了nginx实现负载均衡及https证书

基于springboot框架实现....项目, 其内部主要采用了...技术实现了....功能, 项目整体采用了....设计方式(思想理念)致力于提高代码可复用性、健壮性、
低耦合性、避免幻数、注释