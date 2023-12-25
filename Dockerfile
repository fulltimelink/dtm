FROM alpine:latest

LABEL maintainer="main@fulltime.link"
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# set +8
RUN apk --no-cache add curl tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

# alpine testing package
#RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing duf gops
#RUN apk add --no-cache --repository https://mirrors.aliyun.com/alpine/edge/testing duf
###############################################################################
#                                INSTALLATION
###############################################################################

ADD ./dtm /app/server
RUN chmod +x /app/server
# 设置固定的项目路径
ENV WORKDIR /app

###############################################################################
#                                   START
###############################################################################
WORKDIR $WORKDIR
EXPOSE 36789
EXPOSE 36790
CMD ["./server"]
