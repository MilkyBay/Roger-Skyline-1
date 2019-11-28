[[ -z `find /etc/crontab -mmin -1440` ]]

if [ $? -eq 0 ]
then
	echo "Crontab HAS NOT BEEN modified in the last 24hrs!" | mail -s "Crontab update" root@roger 
else
	echo "Crontab HAS BEEN modified within the last 24hrs!" | mail -s "Crontab update" root@roger
fi
