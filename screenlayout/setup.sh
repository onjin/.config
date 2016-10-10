#!/usr/bin/env bash

SCREENS_COUNT=$(xrandr -q | grep " connected" | wc -l)
VGA_SCREENS_COUNT=$(xrandr -q | grep " connected" | grep -c "VGA")
DVI_SCREENS_COUNT=$(xrandr -q | grep " connected" | grep -c "DVI")
HDMI_SCREENS_COUNT=$(xrandr -q | grep " connected" | grep -c "HDMI")

if [ $SCREENS_COUNT = 2 ]; then
  xrandr --output DVI-0 --primary --auto --below HDMI-0
fi

# nassty hack
# fix acceleration with 2 screens
if [ $SCREENS_COUNT = 1 ]; then
    synclient AccelFactor=0.129366;
else
    synclient AccelFactor=0.03;
fi
