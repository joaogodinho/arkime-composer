#!/bin/sh

echo "Giving ES time to start..."
sleep 10

if [ ! -f /initialized ]; then
    /opt/arkime/db/db.pl elasticsearch:9200 init
    /opt/arkime/bin/arkime_add_user.sh admin "Admin" admin --admin
    touch /initialized
fi

/opt/arkime/bin/docker.sh viewer -n node00
