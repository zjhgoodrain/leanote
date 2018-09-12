FROM debian:sid-slim

ENV TZ=Asia/Shanghai

RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y apt-transport-https ca-certificates procps curl net-tools \
    && curl https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.0.1.tgz >> /usr/local/mongodb-linux-x86_64-3.0.1.tgz \
    && tar xzvf /usr/local/mongodb-linux-x86_64-3.0.1.tgz -C /usr/local \
    && cp /usr/local/mongodb-linux-x86_64-3.0.1/bin/* /usr/local/bin/ \
    && rm -rf mongodb-linux-x86_64-3.0.1.tgz \
    && rm -rf /var/lib/apt/lists/* /usr/local/mongodb-linux-x86_64-3.0.1

ADD app/views /usr/local/leanote/app/views
ADD conf/ /usr/local/leanote/conf
ADD mongodb_backup/ /usr/local/leanote/mongodb_backup
ADD public/ /usr/local/leanote/public
ADD messages/ /usr/local/leanote/messages
ADD bin/ /usr/local/leanote/bin
ADD leanote /usr/local/leanote//bin/leanote
ADD run.sh /usr/local/leanote/bin/run.sh

RUN chmod +x /usr/local/leanote/bin/run.sh

EXPOSE 9000

VOLUME /usr/local/leanote/public/upload /usr/local/leanote/init/

WORKDIR  /usr/local/leanote/bin

ENTRYPOINT ["sh", "run.sh"]