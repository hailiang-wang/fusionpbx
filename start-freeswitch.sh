#!/bin/bash
# Wait until PostgreSQL started and listens on port 5432.
while [ -z "`netstat -tln | grep 5432`" ]; do
  echo 'Waiting for PostgreSQL to start ...'
  sleep 1
done
echo 'PostgreSQL started.'
sleep 10

if test -n "${FUSIONPBX_PASS}" -a ! -f "/data/.pass"; then
    # Set fusionpbx password
    echo "Setting fusionpbx password"
    sudo -u postgres \
	psql -c "ALTER USER fusionpbx WITH PASSWORD '"${FUSIONPBX_PASS}"';"
    # Let future runs know password has been set
    touch /data/.pass
fi

# Start server.
echo 'Starting Freeswitch...'
/usr/bin/freeswitch -u freeswitch -g freeswitch -rp -nonat

