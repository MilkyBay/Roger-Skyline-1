#!/bin/bash

#Включение стороних служб

systemctl enable dbus
systecmtl start dbus
systemctl unmask dbus
systemctl enable exi4
systecmtl start exi4
systemctl unmask exi4
systemctl enable kmod
systecmtl start kmod
systemctl unmask kmod
systemctl enable procps
systecmtl start procps
systemctl unmask procps
systemctl enable rsyslog
systecmtl start rsyslog
systemctl unmask rsyslog
systemctl enable udev
systecmtl start udev
systemctl unmask udev
systemctl enable apparmor
systecmtl start apparmor
systemctl unmask apparmor