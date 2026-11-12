#!/bin/bash
# ptz.sh — control the camera without the app!!!
CAM="${CAM:-192.168.1.3}" #soo um replace ts with your camera local IP!

case "$1" in
    home)     CMD="ptz_gohome" ;;
    stop)     CMD="ptz_stop" ;;
    pos)      CMD="ptz_getpos" ;;
    left)     CMD="ptz_move pan -${2:-100}" ;;
    right)    CMD="ptz_move pan ${2:-100}" ;;
    up)       CMD="ptz_move tilt ${2:-50}" ;;
    down)     CMD="ptz_move tilt -${2:-50}" ;;
    preset)   CMD="ptz_goto_preset $2" ;;
    setpreset)CMD="ptz_set_preset $2" ;;
    *)        echo "usage: $0 {home|stop|pos|left|right|up|down|preset N|setpreset N}"; exit 1 ;;
esac

echo "<SYSTEM>/app/bin/cmd $CMD</SYSTEM>" | nc "$CAM" 1300
