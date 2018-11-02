# 将官方 node:9.3.0-alpine 运行时用作父镜像
FROM node:9.3.0-alpine

RUN mkdir -p /app
# 将工作目录设置为 /app
WORKDIR /app

# 将当前目录内容复制到位于 /app 中的容器中
ADD . /app

# 安装 依赖
RUN npm install -g hexo-cli &&\
    npm install

# 在容器启动时运行
CMD ["hexo", "server"]