---
title: Nginx学习笔记
date: 2019-05-15 16:14:29
tags: 服务器
---

Nginx是一个**轻量级的高性能**HTTP和反向代理服务器, 由俄罗斯人 **伊戈尔·赛索耶夫**

> 这是一个学习笔记, 我想它应该不需要那么详细

## 安装 Nginx

我们既然学习了Docker, 那就要使用Docker

使用 Docker 安装 Nginx

```bash
# 从docker hub中查找nginx
docker search nginx

# 拉取nginx官方最新稳定版 nginx 镜像
docker pull nginx

# 启动 nginx 镜像
docker run -d -p 80:80 --name nginx nginx
```

## Nginx基本概念

### 正则表达式

1. ~  表示执行一个正则匹配，区分大小写
2. ~* 表示执行一个正则匹配，不区分大小写
3. ^~ 表示普通字符匹配。使用前缀匹配。如果匹配成功，则不再匹配其他location。
4. =  进行普通字符精确匹配。也就是完全匹配。
5. @  它定义一个命名的 location，使用在内部定向时，例如 error_page, try_files

### 匹配规则优先级

1. 等号类型（=）的优先级最高。一旦匹配成功，则不再查找其他匹配项。
2. ^~类型表达式。一旦匹配成功，则不再查找其他匹配项。
3. 正则表达式类型（~ ~*）的优先级次之。如果有多个location的正则能匹配的话，则使用正则表达式最长的那个。
4. 常规字符串匹配类型。按前缀匹配。

### 文件及目录匹配

1. -f和!-f用来判断是否存在文件
2. -d和!-d用来判断是否存在目录
3. -e和!-e用来判断是否存在文件或目录
4. -x和!-x用来判断文件是否可执行

### rewrite(重定向)指令的最后一项参数为flag标记，flag标记有

1. last 相当于apache里面的[L]标记，表示rewrite。
2. break 本条规则匹配完成后，终止匹配，不再匹配后面的规则。
3. redirect 返回302临时重定向，浏览器地址会显示跳转后的URL地址。
4. permanent 返回301永久重定向，浏览器地址会显示跳转后的URL地址。

> 使用last和break实现URI重写，浏览器地址栏不变。  
> 使用alias指令必须用last标记;  
> 使用proxy_pass指令时，需要使用break标记。  
> Last标记在本条rewrite规则执行完毕后，会对其所在server{......}标签重新发起请求.  
> break标记则在本条规则匹配完成后，终止匹配。

## Nginx配置文件

```conf
# nginx进程数，建议设置为等于CPU总核心数.
worker_processes 8;

# 全局错误日志定义类型，[ debug | info | notice | warn | error | crit ]
error_log /var/log/nginx/error.log info;

# 进程文件
pid /var/run/nginx.pid;

# 一个nginx进程打开的最多文件描述符数目，理论值应该是最多打开文件数（系统的值ulimit -n）与nginx进程数相除，但是nginx分配请求并不均匀，所以建议与ulimit -n的值保持一致。
worker_rlimit_nofile 65535;

# 工作模式与连接数上限
events
{
　　#参考事件模型，use [ kqueue | rtsig | epoll | /dev/poll | select | poll ]; epoll模型是Linux 2.6以上版本内核中的高性能网络I/O模型，如果跑在FreeBSD上面，就用kqueue模型。
　　use epoll;
　　#单个进程最大连接数（最大连接数=连接数*进程数）
　　worker_connections 65535;
}

# 设定http服务器
http
{

    include mime.types; #文件扩展名与文件类型映射表
    default_type application/octet-stream; #默认文件类型
    #charset utf-8; #默认编码
    server_names_hash_bucket_size 128; #服务器名字的hash表大小
    client_header_buffer_size 32k; #上传文件大小限制
    large_client_header_buffers 4 64k; #设定请求缓
    client_max_body_size 8m; #设定请求缓
    sendfile on; #开启高效文件传输模式，sendfile指令指定nginx是否调用sendfile函数来输出文件，对于普通应用设为 on，如果用来进行下载等应用磁盘IO重负载应用，可设置为off，以平衡磁盘与网络I/O处理速度，降低系统的负载。注意：如果图片显示不正常把这个改成off。
    autoindex on; #开启目录列表访问，合适下载服务器，默认关闭。
    tcp_nopush on; #防止网络阻塞
    tcp_nodelay on; #防止网络阻塞
    keepalive_timeout 120; #长连接超时时间，单位是秒

    #FastCGI相关参数是为了改善网站的性能：减少资源占用，提高访问速度。下面参数看字面意思都能理解。
    fastcgi_connect_timeout 300;
    fastcgi_send_timeout 300;
    fastcgi_read_timeout 300;
    fastcgi_buffer_size 64k;
    fastcgi_buffers 4 64k;
    fastcgi_busy_buffers_size 128k;
    fastcgi_temp_file_write_size 128k;

    #gzip模块设置
    gzip on; #开启gzip压缩输出
    gzip_min_length 1k; #最小压缩文件大小
    gzip_buffers 4 16k; #压缩缓冲区
    gzip_http_version 1.0; #压缩版本（默认1.1，前端如果是squid2.5请使用1.0）
    gzip_comp_level 2; #压缩等级
    gzip_types text/plain application/x-javascript text/css application/xml;
    #压缩类型，默认就已经包含text/html，所以下面就不用再写了，写上去也不会有问题，但是会有一个warn。
    gzip_vary on;
    #limit_zone crawler $binary_remote_addr 10m; #开启限制IP连接数的时候需要使用

    # 应用 myblog 是容器网络中的昵称
    upstream blogs {
        #upstream的负载均衡，weight是权重，可以根据机器配置定义权重。weigth参数表示权值，权值越高被分配到的几率越大。
        # 单台机器 weight 设置无意义
        server myblog:3001 weight=3;
    }

    # 虚拟主机的配置
    server
    {

        listen 80;　　　　#监听端口

        server_name aa.cn www.aa.cn ; #server_name end  #域名可以有多个，用空格隔开

        index index.html index.htm index.php;  # 设置访问主页

        set $subdomain '';  # 绑定目录为二级域名 bbb.aa.com  根目录 /bbb  文件夹

        if ( $host ~* "(?:(\w+\.){0,})(\b(?!www\b)\w+)\.\b(?!(com|org|gov|net|cn)\b)\w+\.[a-zA-Z]+" )
        {
            set $subdomain "/$2";
        }

        root /home/wwwroot/aa.cn/web$subdomain;# 访问域名跟目录  

        include rewrite/dedecms.conf; #rewrite end   #载入其他配置文件


        location ~ .*.(php|php5)?$
        {
        　　fastcgi_pass 127.0.0.1:9000;
        　　fastcgi_index index.php;
        　　include fastcgi.conf;
        }
        #图片缓存时间设置
        location ~ .*.(gif|jpg|jpeg|png|bmp|swf)$
        {
        　　expires 10d;
        }
        #JS和CSS缓存时间设置
        location ~ .*.(js|css)?$
        {
        　　expires 1h;
        }

    }

    # 日志格式设定

    log_format access '$remote_addr - $remote_user [$time_local] "$request" '
    '$status $body_bytes_sent "$http_referer" '
    '"$http_user_agent" $http_x_forwarded_for';
    #定义本虚拟主机的访问日志
    access_log /var/log/nginx/ha97access.log access;

    #对 "/" 启用反向代理
    location / {

        proxy_pass http://127.0.0.1:88;
        proxy_redirect off;
        proxy_set_header X-Real-IP $remote_addr;
        #后端的Web服务器可以通过X-Forwarded-For获取用户真实IP
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        #以下是一些反向代理的配置，可选。
        proxy_set_header Host $host;
        client_max_body_size 10m; #允许客户端请求的最大单文件字节数
        client_body_buffer_size 128k; #缓冲区代理缓冲用户端请求的最大字节数，
        proxy_connect_timeout 90; #nginx跟后端服务器连接超时时间(代理连接超时)
        proxy_send_timeout 90; #后端服务器数据回传时间(代理发送超时)
        proxy_read_timeout 90; #连接成功后，后端服务器响应时间(代理接收超时)
        proxy_buffer_size 4k; #设置代理服务器（nginx）保存用户头信息的缓冲区大小
        proxy_buffers 4 32k; #proxy_buffers缓冲区，网页平均在32k以下的设置
        proxy_busy_buffers_size 64k; #高负荷下缓冲大小（proxy_buffers*2）
        proxy_temp_file_write_size 64k;
        #设定缓存文件夹大小，大于这个值，将从upstream服务器传

    }

    # 设定查看Nginx状态的地址
    location /NginxStatus {

        stub_status on;
        access_log on;
        auth_basic "NginxStatus";
        auth_basic_user_file conf/htpasswd;
        #htpasswd文件的内容可以用apache提供的htpasswd工具来产生。

    }

    #本地动静分离反向代理配置
    #所有jsp的页面均交由tomcat或resin处理
    location ~ .(jsp|jspx|do)?$ {

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://127.0.0.1:8080;

    }
    #所有静态文件由nginx直接读取不经过tomcat或resin
    location ~ .*.(htm|html|gif|jpg|jpeg|png|bmp|swf|ioc|rar|zip|txt|flv|mid|doc|ppt|pdf|xls|mp3|wma)$
    {
        expires 15d;
    }
    location ~ .*.(js|css)?$
    {
        expires 1h;
    }

}
```

### 使用记录

#### nginx热更新

在docker中,实现nginx热更新 `docker exec -i [nginx容器名/id] nginx -s reload`

### nginx 日志配置

[日志配置 参考](https://www.cnblogs.com/biglittleant/p/8979856.html)

## 进阶使用

再文章开始, 我们使用docker安装nginx, 我们完全使用了nginx官方的默认配置, 这里我们将使用自定义配置来启动nginx

首先我们得知道 nginx 官方 docker 镜像得conf文件位置在哪

我得nginx版本conf文件在: /etc/nginx/nginx.conf (可能不同版本的配置文件会有所不同, 所以我们在拉取镜像的时候最好固定版本)

## 相关链接

[Nginx配置文件nginx.conf详解](https://www.cnblogs.com/xuey/p/7631690.html)

[nginx的location配置详解](https://www.cnblogs.com/sign-ptk/p/6723048.html)

## 结语

