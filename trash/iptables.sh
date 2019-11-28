iptables -p INPUT drop -  политика INPUT  по дефолту на DROP
iptables -p input drop -  политика FORWARD по дефолту на DROP
iptables -p OUTPUT drop -  политика OUTPUT по дефолту на ACCEPT

# разрешение только установленных соединений или связанных с установленными
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
# сброс ферментированных пакетов
iptables -A INPUT -f -j DROP
# подсчет и ограничение подключений по tcp для защиты от сканирования портов при 2 подключениях, которые не прошли по правилам
iptables -A INPUT -p tcp -m recent --rcheck --seconds 60 --hitcount 2 --name scan --mask 255.255.255.255 --rsource -j DROP
# подсчет и ограничение подключений по ump для защиты от сканирования портов при 1 подключении, которое не прошло по правилам
iptables -A INPUT -p udp -m recent --rcheck --seconds 60 --hitcount 1 --name scan --mask 255.255.255.255 --rsource -j DROP
# подсчет и ограничение подключений по ssh
iptables -A INPUT -p tcp --dport 5458 -m recent --rcheck --seconds 200 --hitcount 5 --name scan_ssh  —rsource -j DROP
# разрешение на подключение по http, https не больше 40 за секунду
iptables -A INPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW -m limit --limit 40/sec --limit-burst 40 -j ACCEPT
# подсчет подключений по SSH
iptables -A INPUT -p tcp --dport 5458 -m recent --set --name scan_ssh —rsource
# разрешение на подключение по ssh
iptables -A INPUT -p tcp -m multiport --dports 5458 -m conntrack --ctstate NEW -j ACCEPT
# разрешение на 10 подключений с уникального ip
iptables -A INPUT -p tcp -m multiport --dports 80,443 -m connlimit --connlimit-above 10 --connlimit-mask 32 -j DROP
# не больше двух подключений по SSH
iptables -A INPUT -p tcp --dport 5458 -m connlimit --connlimit-above 2 -j DROP
# защита от спама определенными типами пакетов
iptables -A INPUT -p tcp --tcp-flags SYN,ACK,FIN,RST -m limit --limit 1/s --limit-burst 2 -j DROP
# подсчет подключений не по SSH
iptables -A INPUT -p tcp ! --dport 5458 -m recent --set --name scan  --rsource
# подсчет подключений по udp
iptables -A INPUT -p udp -m recent --set --name scan --rsource

# Для обновления конфигурации iptables при каждом ребуте используется утилита iptables-persistent
iptables-save > /etc/iptables/rules.v4
service netfilter-persistent restart
backup iptables - /home/pthuy/iptables.backup
