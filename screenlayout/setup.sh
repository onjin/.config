#!/usr/bin/env bash

SCREENS_COUNT=$(xrandr -q | grep " connected" | wc -l)
VGA_SCREENS_COUNT=$(xrandr -q | grep " connected" | grep -c "VGA")
DVI_SCREENS_COUNT=$(xrandr -q | grep " connected" | grep -c "DVI")
HDMI_SCREENS_COUNT=$(xrandr -q | grep " connected" | grep -c "HDMI")

DVI_NAME=$(xrandr -q |grep " connected" | grep "DVI"|cut -d\  -f 1)
HDMI_NAME=$(xrandr -q |grep " connected" | grep "HDMI"|cut -d\  -f 1)

echo $DVI_NAME

if [ $SCREENS_COUNT = 2 ]; then
  xrandr --output ${DVI_NAME} --primary --auto --below ${HDMI_NAME}
fi

# nassty hack
# fix acceleration with 2 screens
if [ $SCREENS_COUNT = 1 ]; then
    synclient AccelFactor=0.129366;
else
    synclient AccelFactor=0.03;
fi
