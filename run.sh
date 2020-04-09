#!/bin/bash

# run mongodb
/usr/bin/mongod --fork --dbpath /data/db --logpath=/data/db/mongodb.log --logappend
sleep 3


if [ ! -f /data/leanote/.nonInit ];then
	tar xf /tmp/leanote-linux-amd64-v2.6.1.bin.tar.gz -C /data && echo y|rm /tmp/leanote-linux-amd64-v2.6.1.bin.tar.gz
	mongorestore -h localhost -d leanote --dir /data/leanote/mongodb_backup/leanote_install_data/ && echo y| touch  /data/leanote/.nonInit
fi

chmod a+x /data/leanote/bin/run.sh
/data/leanote/bin/run.sh

