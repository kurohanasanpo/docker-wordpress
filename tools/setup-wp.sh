#!/bin/bash

DOCUMENT_ROOT=/var/www/html
WP_NAME=$1

WP_URL=https://${WP_NAME}.wp.test
WP_PATH=${DOCUMENT_ROOT}/${WP_NAME}

DB_NAME=${WP_NAME}
DB_USER=root
DB_PASS=dbadmin123
DB_HOST=mysql
DB_PREFIX=wp_

WP_TITLE=WordPress
WP_USER=wpadmin
WP_PASS=wpadmin123
WP_MAIL=wpadmin@wp.test

#################################################################################
# main
#################################################################################
if [ ! -d ${DOCUMENT_ROOT} ]; then
  echo 'Document Root not found.'
  exit 1
fi

if [ $# -ne 1 ]; then
  echo 'Short arguments.'
  echo "ex) bash $0 wp-install-dir"
  exit 1
fi

if [ -d ${WP_PATH} ]; then
  echo 'Install directory already exist. Delete it and retry.'
  exit 1
fi

# subdirectory
LIST=(${WP_NAME//\// })
DIR1=${LIST[0]}
DIR2=${LIST[1]}
DIR3=${LIST[2]}
if [ ! -z $DIR2 ]; then
  WP_URL=http://${DIR1}.wp.test/${DIR2}
  DB_NAME="${DIR1}_${DIR2}"
fi
if [ ! -z $DIR3 ]; then
  WP_URL=http://${DIR1}.wp.test/${DIR2}/${DIR3}
  DB_NAME="${DIR1}_${DIR2}_${DIR3}"
fi

#
# create database
#
mysql -h mysql -u ${DB_USER} -e "create database \`${DB_NAME}\`;" --password=${DB_PASS}

#
# create directory
#
mkdir -p ${WP_PATH}

#
# download file
#
wp core download --locale=ja --path=${WP_PATH} --allow-root

#
# create config
#
wp core config --path=${WP_PATH} --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS} --dbhost=${DB_HOST} --dbprefix=${DB_PREFIX} --allow-root

#
# install wordpress
#
wp core install --path=${WP_PATH} --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_USER} --admin_password=${WP_PASS} --admin_email=${WP_MAIL} --allow-root

#
# change owner
#
chown -R www-data:www-data ${WP_PATH}

#
# plugins
#
wp plugin install wp-multibyte-patch --activate --path=${WP_PATH} --allow-root
wp plugin delete hello --path=${WP_PATH} --allow-root
wp plugin delete akismet --path=${WP_PATH} --allow-root

#
# delete themes
#
wp theme delete --all --path=${WP_PATH} --allow-root
