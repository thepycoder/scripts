# Script for Terminating TeamViewer Desktop Client upon exit.

# TeamViewer Version: 15.45.3

#!/bin/bash

# User

user=$(whoami)

# Log File Location

logfile='TeamViewer15_Logfile.log'

logpath="/opt/teamviewer/logfiles/$user"

# Executables

tvpath='/opt/teamviewer/tv_bin'

tvdesktop='TeamViewer_Desktop'

tvclient='TeamViewer'

# Logging times for when session terminates

i=0

while [ "$i" -lt 1000000 ]

do

i=$((i + 1))

echo "This is the ${i}th session."

echo "-------------------------------------------------------------------------------------------------------------------"

ps aux | grep "teamviewer"

echo "-------------------------------------------------------------------------------------------------------------------"

echo ""

logout=$(date -d"$(cat $logpath/$logfile | grep 'SessionTerminate' | tail -n 1 | awk '{print $1,$2}')")

echo "Previous Logout time is: $logout"

echo ""

logout_check=$logout

while [ "$logout_check" = "$logout" ]

do

logout_check=$(date -d"$(cat $logpath/$logfile | grep "SessionTerminate" | tail -n 1 | awk '{print $1,$2}')")

done

kill -9 $(ps aux | grep "$tvpath/$tvclient" | awk "{print $2}")

done