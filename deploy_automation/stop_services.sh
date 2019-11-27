#!/bin/bash

#Отключение стороних служб

systemctl disable dbus
systecmtl stop dbus
systemctl mask dbus
systemctl disable exi4
systecmtl stop exi4
systemctl mask exi4
systemctl disable kmod
systecmtl stop kmod
systemctl mask kmod
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