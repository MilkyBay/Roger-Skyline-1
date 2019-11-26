[[ -z `find /etc/crontab -mmin -1440` ]]

if [ $? -eq 0 ]
then
	echo "/etc/crontab has not been modified in the last 24hrs!" | mail -s "Crontab update" root@roger 
else
	echo "/etc/crontab has been modified within the last 24hrs!" | mail -s "Crontab update" root@roger
fi
