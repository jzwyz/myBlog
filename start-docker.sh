# 运行镜像 映射内部4000端口到本机4000端口 使用本机source文件夹作为容器内部/app/source数据卷 --rm参数
docker run -d --rm -v ~/../workspace/my-blog/source:/app/source --network=app-bridge --name=myblog registry.cn-hangzhou.aliyuncs.com/jiangzwyz/myblog
