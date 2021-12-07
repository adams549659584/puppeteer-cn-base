FROM node:16.13.0-alpine3.14

LABEL maintainer="罗君"

# 设置阿里云源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# basic tools
RUN apk update && apk upgrade \
    && apk add --no-cache \
    udev  \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    coreutils \
    curl \
    ffmpeg \
    figlet \
    jq \
    moreutils \
    bash \
    xauth \
    tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata \
    && rm -rf /tmp/* /var/cache/apk/*
#end

#  set PUPPETEER
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
# end 

# 淘宝源
RUN npm config set registry https://registry.npmmirror.com/
RUN npm i -g npm   
RUN npm i -g puppeteer@11.0.0

# 微软雅黑字体，解决中文乱码
COPY fonts/* /usr/share/fonts/