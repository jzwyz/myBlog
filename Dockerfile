# 将官方 node:9.3.0-alpine 运行时用作父镜像
FROM node:12.16.1-alpine AS builder
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

# 运行
FROM node:12.16.1-alpine
# 同步时区和时间
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata
WORKDIR /app
COPY --from=builder /app .
EXPOSE 4000
ENTRYPOINT [ "hexo", "server" ]
