FROM daocloud.io/debian:buster

COPY sources.list /etc/apt/sources.list
RUN apt-get -yy update;apt-get -yy install wget gnupg && wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/mongodb/apt/debian buster/mongodb-org/stable main" > /etc/apt/sources.list.d/mongodb.list
RUN apt-get -yy update && apt-get install -yy mongodb-org && apt-get clean all

RUN mkdir -p /data/db && chown -R mongodb /data/db

COPY mongod.conf /etc/mongod.conf
COPY run.sh /run.sh

WORKDIR /data/leanote

RUN wget -c http://sourceforge.net/projects/leanote-bin/files/2.6.1/leanote-linux-amd64-v2.6.1.bin.tar.gz/download -O /tmp/leanote-linux-amd64-v2.6.1.bin.tar.gz
RUN chmod a+x /run.sh

VOLUME /data/db
VOLUME /data/leanote

EXPOSE 27017 28017 9000

ENTRYPOINT ["/run.sh"]
