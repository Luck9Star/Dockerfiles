FROM debian:jessie
MAINTAINER Luck9Star <hadyenvip@gmail.com>
ENV V2RAY_VERSION 1.7
ENV V2RAY /v2ray
ENV V2RAY_CONTENT $V2RAY/content
ENV V2RAY_CONFIG_CONTENT $V2RAY_CONTENT/config
ENV V2RAY_LOG_CONTENT $V2RAY_CONTENT/logs
ADD https://github.com/v2ray/v2ray-core/releases/download/v$V2RAY_VERSION/v2ray-linux-64.zip /tmp/
RUN apt-get update && apt-get install -y unzip &&\
unzip -o /tmp/v2ray-linux-64.zip -d /tmp && mv /tmp/v2ray-v$V2RAY_VERSION-linux-64 $V2RAY &&\
mkdir -p $V2RAY_CONTENT &&\
chmod +x $V2RAY/v2ray &&\
apt-get remove --auto-remove -y unzip && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/v2ray*
COPY docker-entrypoint.sh /entrypoint.sh
VOLUME $V2RAY_CONTENT
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 17173
CMD ["sh", "-c", "$V2RAY/v2ray -config $V2RAY_CONFIG_CONTENT/config.json"]
