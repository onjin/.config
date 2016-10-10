#!/bin/sh

if [ $DVI_SCREENS_COUNT = 1 ]; then
	SCREEN='DVI-0'
fi

if [ $HDMI_SCREENS_COUNT = 1 ]; then
	SCREEN='HDMI-0'
fi

xrandr --output DVI-0 --primary --auto --below HDMI-0
