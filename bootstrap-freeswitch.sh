#!/bin/bash -xe

if ! test -f ${PERSIST_DIR}/.bootstrapped; then
    # This is the first run

    # - Install seed files into persistent volume
    cp -a ${SEED_DIR}/* ${PERSIST_DIR}

    # - Signal to following runs bootstrapping is already done
    touch ${PERSIST_DIR}/.bootstrapped

fi

# Start supervisord
exec /usr/bin/supervisord -nc /etc/supervisor/supervisord.conf
