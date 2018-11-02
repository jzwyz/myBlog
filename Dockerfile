# 将官方 node:9.3.0-alpine 运行时用作父镜像
FROM node:9.3.0-alpine

RUN mkdir -p /app
# 将工作目录设置为 /app
WORKDIR /app

# 将当前目录内容复制到位于 /app 中的容器中
COPY . /app/temp

RUN cp /app/temp/package.json /app/package.json && \
    cp /app/temp/package-lock.json /app/package-lock.json && \
    npm install &&\
    cp /app/temp/_config.yml /app/_config.yml && \
    cp /app/temp/themes /app/themes && \
    cp /app/temp/source /app/source && \
    cp /app/temp/scaffolds /app/scaffolds &&\
    rm -rf /app/temp
    
RUN npm install -g hexo-cli
# 在容器启动时运行
CMD ["hexo", "server"]