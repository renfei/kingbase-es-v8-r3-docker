#!/bin/sh

DB_PATH=/opt/kingbase
DATA_DIR=/opt/kingbase/data
LOG_FILE=${DB_PATH}/logfile

rm -rf ${DATA_DIR}/.DS_Store

check_is_init() {
  declare -g DATABASE_ALREADY_EXISTS
  if [ -d "${DATA_DIR}" -a `ls -A ${DATA_DIR}|wc -w` -ne 0 ];then
    DATABASE_ALREADY_EXISTS='true'
  fi
}

db_init(){
  mkdir -p ${DATA_DIR}
  chown -R kingbase:kingbase ${DATA_DIR}
  cd ${DB_PATH}/Server/bin/
  extraParams="--encoding=UTF8 --case-insensitive"
  ./initdb -USYSTEM -W${SYSTEM_PWD-123456} -E UTF8 ${DATA_DIR} ${extraParams}
}

check_is_init
if [ -z "${DATABASE_ALREADY_EXISTS}" ];then
  db_init
  if [ $? -ne 0 ];then
    echo "initdb failed"
    exit 1
  fi
fi

if [ -f "${DB_PATH}/Server/bin/license.dat" ];then
  cp ${DB_PATH}/Server/bin/license.dat ${DB_PATH}/
fi

${DB_PATH}/Server/bin/sys_ctl -D ${DATA_DIR} -l ${LOG_FILE} start

sleep 15

exec tail -f ${LOG_FILE}