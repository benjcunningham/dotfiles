#!/bin/bash

MAX_VOL=150

pactl_level() {
  pactl list sinks | grep "Volume: front-left" | cut -d '/' -f 2 | grep -Eo "[0-9]+"
}

case $1 in
  mic)
    for SOURCE in `pacmd list-sources | grep 'index:' | cut -d ':' -f 2`; do
      case $2 in
        mute) pactl set-source-mute $SOURCE toggle
      esac
    done
  ;;
  volume)
    for SINK in `pacmd list-sinks | grep 'index:' | cut -d ':' -f 2`; do
      case $2 in
        mute) pactl set-sink-mute $SINK toggle ;;
        *)    if (( $(pactl_level) >= $MAX_VOL )); then
                if (( $(echo $2 | grep -Eo "\-*[0-9]+") < 0 )); then
                  pactl set-sink-volume $SINK $2;
                fi
              else
                pactl set-sink-volume $SINK $2;
              fi
      esac
    done
esac

