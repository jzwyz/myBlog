# 基于 hexo框架 的个人博客项目

1. Hexo框架的博客
2. 使用 Annie 主题

## 其他说明

1. 使用到的图片资源 由 [Unsplash Source](https://source.unsplash.com) 提供
2. db.json 是 annie 主题使用

## 运行镜像 映射内部4000端口到本机4000端口 使用本机source文件夹作为容器内部/app/source数据卷 --rm参数

```bash
docker run -d -p 4000:4000 --rm -v ~/myWorkspace/myproject/myblog/source:/app/source --network=app-bridge --name=webblog myblog:1.0
```

```bash
docker run -d --rm -v ~/../workspace/my-blog/source:/app/source --network=app-bridge --name=webblog myblog:1.0
```