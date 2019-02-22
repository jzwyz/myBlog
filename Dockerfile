# 将官方 node:9.3.0-alpine 运行时用作父镜像
FROM node:9.3.0-alpine

RUN mkdir -p /app
# 将工作目录设置为 /app
WORKDIR /app

# 将当前目录内容复制到位于 /app 中的容器中
COPY . /app/temp

RUN cp /app/temp/package.json /app/package.json &&\
    npm install --registry=https://registry.npm.taobao.org &&\
    cp /app/temp/_config.yml /app/_config.yml &&\
    cp -r /app/temp/themes /app/themes &&\
    cp -r /app/temp/scaffolds /app/scaffolds &&\
    rm -rf /app/temp
    
RUN npm install -g hexo-cli --registry=https://registry.npm.taobao.org &&\
    npm install hexo-generator-search-zip --save --registry=https://registry.npm.taobao.org

# 在容器启动时运行
CMD ["hexo", "server"]
