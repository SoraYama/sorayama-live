FROM node:9-alpine as html

ENV PROJECT_DIR=/app \
    ONLINE_DEV=true

WORKDIR $PROJECT_DIR

COPY ./package.json .
COPY ./yarn.lock .

#RUN yarn --registry=https://registry.npm.taobao.org
RUN yarn --registry=https://npmreg.proxy.ustclug.org

COPY . .

RUN yarn run build

FROM nginx:alpine

RUN sed -i 's#http://dl-cdn.alpinelinux.org#https://mirrors.ustc.edu.cn#g' /etc/apk/repositories

# 时区
RUN apk add --no-cache tzdata
ENV TZ Asia/Shanghai

COPY --from=html /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx","-g","daemon off;"]
