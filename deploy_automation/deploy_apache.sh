#!/bin/bash

# Устанавливаем переменные, зависимости и обновляем пакеты
# Первая строка нужна для того, чтобы нормально отрабатывался скрипт

DEBIAN_FRONTEND=noninteractive
user=pthuy
psw=kong

apt update -y && apt upgrade -y

apt -y install sudo openssh-server fail2ban mailutils apache2 iptables-persistent

# Создаем пользователя и добавляем его в группу sudo
# Данные флаги нужны для того, чтобы создать пользователя
# -m создание домашнего каталога, -d указание директории, -s указание оболочки
# Вторая строка для задания пароля, чтобы это все нормально работало в скрипте

useradd -m -d /home/$user -s /bin/bash $user
echo $user:$psw | chpasswd
adduser $user sudo

# Копируем настройки сетевых адаптеров
# Все параметры прописаны в шаблоне, которым мы заменяем дефолтный файл

rm -rf /etc/network/interfaces
cp assets/ip_config/interfaces /etc/network/

# Настройка SSH
# Копируем готовый шаблон и копируем открытый ключ, который мы заранее создали, в файл authorized_keys

rm -rf /etc/ssh/sshd_config
cp assets/ssh/sshd_config /etc/ssh/
mkdir /home/$user/.ssh
cat assets/ssh/id_rsa.pub > /home/$user/.ssh/authorized_keys

#Настройка Fail2Ban
#Здесь опять же копируем заранее заготовленные шаблоны
#Сюда входит настройка фаервола и защита от DOS

rm -rf /etc/fail2ban/jail.local
cp assets/fail2ban/jail.local /etc/fail2ban/

# Копирование скриптов cron для обновлений и определения изменений в cron

cp -r assets/scripts /root

# Перенос файлов моего великолепного сайта
# Каркас страницы и фотка

rm -rf /var/www/html/index.html
cp assets/apache2/index.html /var/www/html/
cp assets/apache2/seal.jpg /var/www/html/


# Создание сертификата SSL и его настройка
# Копируем конфиги для подключения сертификата на сайт + в них прописан редирект с http на https
# Последнии строчки для активации модулей apache2

yes "y" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -subj "/C=RU/ST=Moscow/L=Moscow/O=21/OU=Student/CN=localhost"

cp assets/apache2/ssl/ssl-params.conf /etc/apache2/conf-available/
rm -rf /etc/apache2/sites-available/default-ssl.conf
cp assets/apache2/ssl/default-ssl.conf /etc/apache2/sites-available/
rm -rf /etc/apache2/sites-available/000-default.conf
cp assets/apache2/ssl/000-default.conf /etc/apache2/sites-available/

a2enmod ssl
a2enmod headers
a2ensite default-ssl
a2enconf ssl-params

# Защиты от DOS и сканирования

#sh dos_scan_prot.sh

# Отключение неиспользуемых служб

sh stop_services.sh

# Перезапуск системы для полной уверенности, что все изменения корректно применились

shutdown -r now
