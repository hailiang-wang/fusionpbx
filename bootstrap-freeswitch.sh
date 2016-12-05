#!/bin/bash

if ! test -f ${PERSIST_DIR}/.bootstrapped; then
    # This is the first run; install seed files into persistent volume
    cp -a ${SEED_DIR}/* ${PERSIST_DIR}
    touch ${PERSIST_DIR}/.bootstrapped
fi

# Start supervisord
exec /usr/bin/supervisord -n
