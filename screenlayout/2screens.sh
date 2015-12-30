#!/bin/sh

if [ $VGA_SCREENS_COUNT = 1 ]; then
	$SCREEN='VGA1'
fi

if [ $HDMI_SCREENS_COUNT = 1 ]; then
	$SCREEN='HDMI1'
fi

xrandr --output LVDS1 --off
xrandr --output ${SCREEN} --primary --auto
