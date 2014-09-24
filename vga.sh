#!/bin/bash

MODELINE=`cvt 1600 900 | grep Modeline | cut -d" " -f3-20`
MODENAME="1600x900_60_opt"
xrandr --rmmode "$MODENAME" 2>/dev/null
xrandr --newmode "$MODENAME" $MODELINE
xrandr --delmode VGA1 "$MODENAME" 2>/dev/null
xrandr --addmode VGA1 "$MODENAME"
