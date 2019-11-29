#!/bin/bash

#Отключение стороних служб

# dbus - это система, которая используется в основном в операционной системе Linux для того, чтобы различные приложения и сервисы могли общаться между собой.
# exim4 - это агент пересылки почты. Данный пакет является метапакетом, зависящим от основных компонентов, необходимых для базовой установки exim4.
# kmod - этот пакет содержит набор программ для загрузки, подключения и удаления модулей ядра Linux.
# procps - этот пакет содержит следующие утилиты: free, kill, pkill, pgrep, pmap, ps, pwdx, skill, slabtop, snice, sysctl, tload, top, uptime, vmstat, w, watch.
# rsyslog - эта служба является службой ведения протоколов по умолчанию в системах Debian.
# udev - это служба, которая динамически создаёт и удаляет файлы устройств в каталоге /dev/, обрабатывает события добавления/удаления устройств «на лету» и загружает драйверы при запуске операционной системы.
# apparmor - это модуль безопасности ядра Linux, который позволяет ограничивать возможности программ с помощью их индивидуальных профилей.

#systemctl disable dbus
#systecmtl stop dbus
#systemctl mask dbus
systemctl disable exim4
systecmtl stop exim4
systemctl mask exim4
#systemctl disable kmod
#systecmtl stop kmod
#systemctl mask kmod
systemctl disable procps
systecmtl stop procps
systemctl mask procps
systemctl disable rsyslog
systecmtl stop rsyslog
systemctl mask rsyslog
systemctl disable udev
systecmtl stop udev
systemctl mask udev
systemctl disable apparmor
systecmtl stop apparmor
systemctl mask apparmor