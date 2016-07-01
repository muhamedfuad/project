#!/bin/bash

echo -e "\n" >> /tmp/info
echo -e "A) Various System Configuration Relates To User and Os..." >> /tmp/info
echo -e "-------------------------------------------------------------------" >> /tmp/info
nouser=`who | wc -l`
echo -e "User name: $USER (Login name: $LOGNAME)" >> /tmp/info
echo -e "Current Shell: $SHELL"  >> /tmp/info
echo -e "Home Directory: $HOME" >> /tmp/info
echo -e "Your O/s Type: $OSTYPE" >> /tmp/info
echo -e "Your O/s Version: `uname -mrs`" >> /tmp/info
echo -e "PATH: $PATH" >> /tmp/info
echo -e "Current directory: `pwd`" >> /tmp/info
echo -e "Currently Logged: $nouser user(s)" >> /tmp/info

if [ -f /etc/redhat-release ]
then
    echo -e "OS: `cat /etc/redhat-release`" >> /tmp/info
fi

if [ -f /etc/shells ]
then
    echo -e "Available Shells: " >> /tmp/info
    echo -e "`cat /etc/shells`"  >> /tmp/info
fi
    
echo -e "\n" >> /tmp/info
echo -e "-------------------------------------------------------------------" >> /tmp/info
echo -e "B) Data Related To Load On The Server..." >> /tmp/info
echo -e "Load on your server : `uptime`" >> /tmp/info
echo -e "`free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'`" >> /tmp/info
echo -e "`df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)", $3,$2,$5}'`
" >> /tmp/info
echo -e "`top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}'`" >> /tmp/info
echo -e "\n" >> /tmp/info
echo -e "-------------------------------------------------------------------" >> /tmp/info
echo -e "C) Top 5 Processes With Maximum Number Of Threads..." >> /tmp/info
echo -e "`ps axo nlwp,pid,cmd | sort -rn | head -5`" >> /tmp/info

echo -e "\n" >> /tmp/info
echo -e "-------------------------------------------------------------------" >> /tmp/info
echo -e "D) 10 Services Sorted By Memory..." >> /tmp/info
echo -e "`ps aux --sort -rss | head -10`" >> /tmp/info

if which dialog > /dev/null
then
    dialog  --backtitle "Linux Software Diagnostics (LSD) Shell Script Ver.1.0" --title "Press Up/Down Keys to move" --textbox  /tmp/info
else
    cat /tmp/info |more
fi

rm -f /tmp/info
