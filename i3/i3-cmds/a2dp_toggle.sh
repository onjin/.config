#!/bin/bash

HEADPHONES_ID="HD 4.5"

CARD=$(pacmd list-cards|grep bluez_card|tr '>' '<'| cut -d'<' -f2)
CARD_NUMBER=$(echo $CARD|cut -d. -f2)

####  Restart Bluetooth
if [ "$1" == "resetBT" ] ; then
  sudo rfkill block bluetooth && sleep 0.1 && sudo rfkill unblock bluetooth;
  exit;
fi;

#### Toggle listen/speak
if [ "$1" == "" -o "$1" == "toggle" ] ; then
  LINE=`pacmd list-sinks  | grep '\(name:\|alias\)' | grep -B1 "${HEADPHONES_ID}"  | head -1`
  if [ "$LINE" == "" ] ; then echo "${HEADPHONES_ID} headset not found"; exit; fi

  SINK_NAME="bluez_sink.${CARD_NUMBER}.a2dp_sink"
  if $(echo "$LINE" | grep $SINK_NAME &> /dev/null) ; then
    echo "Detected quality sound output, that means we can't speak; switch that."
    $0 speak;
  else
    echo "Quality sound not found, switch to the good sound."
    $0 listen;
  fi
fi

#### Change the output to F5A
if [ "$1" == "listen" ] ; then
  LINE=`pacmd list-sinks  | grep '\(name:\|alias\)' | grep -B1 "${HEADPHONES_ID}"  | head -1`
  if [ "$LINE" == "" ] ; then echo "${HEADPHONES_ID} phones not found"; exit; fi
  #        name: <bluez_sink.00_19_5D_25_6F_6C.headset_head_unit>

  ## Get what's between <...>
  SINK_NAME=`echo "$LINE" | tr '>' '<' | cut -d'<' -f2`;

  ## Switch the output to that.
  echo "Switching audio output to $SINK_NAME";
  pacmd set-default-sink "$SINK_NAME"

  #### Change profile to quality output + no mic. From `pacmd list-cards`:
  PROFILE="a2dp_sink"   
  notify-send "$0" "Switching audio profile to A2DP";
  pacmd set-card-profile $CARD $PROFILE
  exit;
fi;

#### Input
if [ "$1" == "speak" ] ; then
  ## Change profile to crappy output + mic. From `pacmd list-cards`:
  pacmd set-card-profile $CARD headset_head_unit

  LINE=`pacmd list-sources | grep '\(name:\|alias\)' | grep -B1 "${HEADPHONES_ID}"  | head -1`
  if [ "$LINE" == "" ] ; then echo "${HEADPHONES_ID} mic not found"; exit; fi
  SOURCE_NAME=`echo "$LINE" | tr '>' '<' | cut -d'<' -f2`;

  notify-send "$0" "Switching audio input to HSP/HFP";
  pacmd set-default-source "$SOURCE_NAME" || echo 'Try `pacmd list-sources`.';
fi;
