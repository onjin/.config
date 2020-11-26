#!/usr/bin/env bash

SCREENS_COUNT=$(xrandr -q | grep " connected" | wc -l)
VGA_SCREENS_COUNT=$(xrandr -q | grep " connected" | grep -c "VGA")
DVI_SCREENS_COUNT=$(xrandr -q | grep " connected" | grep -c "DVI")
HDMI_SCREENS_COUNT=$(xrandr -q | grep " connected" | grep -c "HDMI")
DP_SCREENS_COUNT=$(xrandr -q | grep " connected" | grep -c "DP")

DVI_NAME=$(xrandr -q |grep " connected" | grep "DVI"|cut -d\  -f 1)
HDMI_NAME=$(xrandr -q |grep " connected" | grep "HDMI"|cut -d\  -f 1)
DP_NAME=$(xrandr -q |grep " connected" | grep "DP"|cut -d\  -f 1)

echo $DVI_NAME
echo $HDMI_NAME
echo $DP_NAME

if [ ! -z $DP_NAME  ]; then
  echo xrandr --output ${DVI_NAME} --primary --auto --below ${HDMI_NAME} --output ${DP_NAME} --auto --rotate right --left-of ${HDMI_NAME}
  xrandr --output ${DVI_NAME} --primary --auto --below ${HDMI_NAME} --output ${DP_NAME} --auto --rotate right --left-of ${HDMI_NAME}
else
    echo xrandr --output ${DVI_NAME} --primary --auto --below ${HDMI_NAME}
    xrandr --output ${DVI_NAME} --primary --auto --below ${HDMI_NAME}
fi
