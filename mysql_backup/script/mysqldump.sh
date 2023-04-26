#!/bin/bash

BK_DIR=/home/root/backup
BK_PREFIX=dump_
BK_FILE=${BK_PREFIX}`date '+%Y%m%d-%H%M%S'`.sql
BK_NUM=32
DB_USER=root
DB_PASS=dbadmin123

# mkdir
/bin/mkdir -p ${BK_DIR}

# dump
/usr/bin/mysqldump -h mysql -u ${DB_USER} -p${DB_PASS} --all-databases > ${BK_DIR}/${BK_FILE}

# zip
/bin/gzip ${BK_DIR}/${BK_FILE}

# rotation
/bin/ls -t ${BK_DIR}/${BK_PREFIX}* | /usr/bin/tail -n +${BK_NUM} | /usr/bin/xargs /bin/rm
