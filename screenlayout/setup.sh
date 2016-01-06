#!/usr/bin/env bash

SCREENS_COUNT=$(xrandr -q | grep " connected" | wc -l)
VGA_SCREENS_COUNT=$(xrandr -q | grep " connected" | grep "VGA1" | wc -l)
HDMI_SCREENS_COUNT=$(xrandr -q | grep " connected" | grep "HDMI1" | wc -l)

if [ $SCREENS_COUNT = 1 ]; then
	xrandr --output HDMI1 --off --output VGA1 --off --output LVDS1 --auto --primary
fi

if [ $SCREENS_COUNT = 2 ]; then
	if [ $VGA_SCREENS_COUNT = 1 ]; then
		xrandr --output LVDS1 --off --output VGA1 --primary --auto
	fi

	if [ $HDMI_SCREENS_COUNT = 1 ]; then
		xrandr --output LVDS1 --off --output HDMI1 --primary --auto
	fi
fi

if [ $SCREENS_COUNT = 3 ]; then
	xrandr --output LVDS1 --off --output VGA1 --auto --output HDMI1 --left-of VGA1 --primary --auto
fi

# nassty hack
# fix acceleration with 2 screens
if [ $SCREENS_COUNT = 1 ]; then
    synclient AccelFactor=0.129366;
else
    synclient AccelFactor=0.03;
fi
