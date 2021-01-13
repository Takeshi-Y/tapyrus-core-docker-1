#!/bin/bash -eu

if [ ! -e ${CONF_DIR}/tapyrus.conf ]; then
  cat << EOS > ${CONF_DIR}/tapyrus.conf
rpcuser=rpcuser
rpcpassword=rpcpassword
bind=0.0.0.0
rpcallowip=0.0.0.0/0

server=1
discover=0

dev=1
[dev]
port=12383
rpcport=12381
networkid=1905960821
EOS
fi

if [ -v NETWORK_ID ]; then
  network_id=${NETWORK_ID}
else
  network_id=`cat ${CONF_DIR}/tapyrus.conf | grep networkid= | grep -oE "[0-9]+"`
fi

if [ -v GENESIS_BLOCK_WITH_SIG -a ! -e ${DATA_DIR}/genesis.${network_id} ]; then
  echo ${GENESIS_BLOCK_WITH_SIG} > ${DATA_DIR}/genesis.${network_id}
fi

exec bash -c "$*"
