#!/bin/bash

# ID = window ID which is a memory address\
# pos = order number which is the position of the window in the list of all windows

# Get active window ID (memory address without 0x0 in front)
active_win_id=`xprop -root | grep '^_NET_ACTIVE_W' | awk -F'# 0x' '{print $2}' | awk -F', ' '{print $1}'`
if [ "$active_win_id" == "0" ]; then
    active_win_id=""
fi

# Get current workspace, we only want to cycle between windows within one workspace
workspace_number=`wmctrl -d | grep '\*' | cut -d' ' -f 1`

# Get list of active windows in current workspace
win_list=`wmctrl -lx | grep " $workspace_number "`

# Get the maximum window ID so we can overflow when swiping left on window 0
max_window_id=`echo "$win_list" | wc -l`

# Get the pos of the currently active window
current_pos=`echo "$win_list" | grep -n $active_win_id | cut -d : -f 1`

# Decide to go either up or down one pos in the list depending on the argument (which can be linked to touchpad gesture)
if [[ $1 ]];then
    switch_to_pos=$(($current_pos - 1))
else
    switch_to_pos=$(($current_pos + 1))
fi

# Get next window by returning line at position pos
switch_to_id=`echo "$win_list" | sed -n ${switch_to_pos}p`

# If the current window is the last in the list ... take the first one or the other way around
if [ "$switch_to_id" == "" ];then
    if [[ $1 ]];then
        overflow_id=$max_window_id
    else
        overflow_id=1
    fi
    # Switch to the new window
    switch_to_id=`echo "$win_list" | sed -n ${overflow_id}p`
fi

# Execute the actual window switch
if [[ -n "${switch_to_id}" ]]
    then
        (wmctrl -ia "$switch_to_id") &
fi


exit 0