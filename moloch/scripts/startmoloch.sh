#!/bin/sh

echo "Giving ES time to start..."
sleep 30
until curl -sS "http://$ES_HOST:$ES_PORT/_cluster/health?wait_for_status=yellow"
do
    echo "Waiting for ES to start"
    sleep 1
done
echo

if [ ! -f /data/initialized ]; then
	touch /data/initialized
    /data/moloch/bin/Configure
	/data/moloch/db/db.pl http://$ES_HOST:$ES_PORT init
	/data/moloch/bin/moloch_add_user.sh admin "Admin User" $MOLOCH_ADMIN_PASSWORD --admin
fi

if [ "$CAPTURE" = "on" ]
then
    echo "Launch capture..."
    if [ "$VIEWER" = "on" ]
    then
        # Background execution
        exec $MOLOCHDIR/bin/moloch-capture >> $MOLOCHDIR/logs/capture.log 2>&1 &
    else
        # If only capture, foreground execution
        exec $MOLOCHDIR/bin/moloch-capture >> $MOLOCHDIR/logs/capture.log 2>&1
    fi
fi

if [ "$VIEWER" = "on" ]
then
    echo "Launch viewer..."
    exec $MOLOCHDIR/bin/node $MOLOCHDIR/viewer/viewer.js -c $MOLOCHDIR/etc/config.ini >> $MOLOCHDIR/logs/viewer.log 2>&1
fi

echo "Look at log files for errors"
echo "  /data/moloch/logs/viewer.log"
echo "  /data/moloch/logs/capture.log"
echo "Visit http://127.0.0.1:8005 with your favorite browser."
echo "  user: admin"
echo "  password: $MOLOCH_ADMIN_PASSWORD"