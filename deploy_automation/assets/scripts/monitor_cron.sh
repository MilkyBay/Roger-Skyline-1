#!/bin/sh
MSG="File /etc/crontab has been modified!"
SUBJECT="Monitor changes crontab"
TO="root@localhost"
HASH="/etc/cron.d/hash.txt"
FILE="/etc/crontab"
test -f $HASH || touch $HASH
CRON_HASH=$(md5sum $FILE)
if [ "$(cat $HASH)" != "$CRON_HASH" ]; then
     echo $CRON_HASH > $HASH
     echo $MSG | mail -s "$SUBJECT" $TO
fi;
exit
