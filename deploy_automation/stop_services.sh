#!/bin/bash

#Отключение стороних служб

systemctl disable dbus
systemctl disable exi4
systemctl disable kmod
systemctl disable procps
systemctl disable rsyslog
systemctl disable udev
