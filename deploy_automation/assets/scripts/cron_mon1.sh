#!/bin/bash

DIFF=$(diff /etc/crontab.bak /etc/crontab)

cat /etc/crontab > /etc/crontab.bak

if [ "$DIFF" != ""] then
    echo "crontab check: changed, notifying admin."
    sendmail root@127.0.0.1 < ~/mail.txt
else
    echo "crontab check: unchanged."
fi