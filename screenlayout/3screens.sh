#!/bin/sh
xrandr --output LVDS1 --off

# xrandr --newmode "1280x1024_60.00"  108.88  1280 1360 1496 1712  1024 1025 1028 1060  -HSync +Vsync
# xrandr --addmode VGA1  1280x1024_60.00
# xrandr --output VGA1 --mode 1280x1024_60.00
xrandr --output VGA1 --auto

xrandr --output HDMI1 --left-of VGA1 --primary --auto
