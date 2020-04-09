#!/bin/bash

# run mongodb
/usr/bin/mongod --fork --dbpath /data/db --logpath=/data/db/mongodb.log --logappend
sleep 3

if [ ! -f /data/leanote/.nonInit ];then
	mongorestore -h localhost -d leanote --dir mongodb_backup/leanote_install_data/ && echo y| touch  /data/leanote/.nonInit
fi

/data/leanote/bin/run.sh

