# 将官方 arm64v8/node:9.3.0-alpine 运行时用作父镜像
FROM arm64v8/node:10.17.0-alpine3.9

RUN mkdir -p /app

# 将工作目录设置为 /app
WORKDIR /app

# 将当前目录内容复制到位于 /app 中的容器中
COPY . /app/temp

RUN cp /app/temp/package.json /app/package.json \
    && cp /app/temp/package-lock.json /app/package-lock.json \
    && npm update --registry=https://registry.npm.taobao.org \
    && npm install --registry=https://registry.npm.taobao.org \
    && mkdir /app/themes \
    && cp -r /app/temp/themes/aircloud /app/themes/aircloud \
    && cp -r /app/temp/scaffolds /app/scaffolds \
    && cp -r /app/temp/source /app/source \
    && cp /app/temp/_config.yml /app/_config.yml \
    && rm -rf /app/temp

RUN npm i -g hexo-cli --registry=https://registry.npm.taobao.org

# 在容器启动时运行
CMD ["hexo", "server"]
