#!/bin/sh
printf "Camera IP: "
read CAM
if [ -z "$CAM" ]; then
  echo "no IP"
  exit 1
fi
while :; do
  printf "\n"
  printf "1  alarm.aac\n"
  printf "2  burn_success.aac\n"
  printf "3  factesting.aac\n"
  printf "4  nocid.aac\n"
  printf "5  vcall_on.aac\n"
  printf "6  wozai.aac\n"
  printf "7  en/bind_success.aac\n"
  printf "8  en/call_busy.aac\n"
  printf "9  en/call_on.aac\n"
  printf "10 en/connecting.aac\n"
  printf "11 en/di.aac\n"
  printf "12 en/hangup.aac\n"
  printf "13 en/nosim.aac\n"
  printf "14 en/op0.aac\n"
  printf "15 en/reset.aac\n"
  printf "16 en/sigerr.aac\n"
  printf "17 en/upgrade.aac\n"
  printf "18 en/welcome.aac\n"
  printf "19 en/welcome_4g.aac\n"
  printf "20 en/welcome_wifi.aac\n"
  printf "21 en/wifi_connect_fail.aac\n"
  printf "22 en/wifi_on.aac\n"
  printf "23 en/wozai.aac\n"
  printf "24 zh/bind_success.aac\n"
  printf "25 zh/call_busy.aac\n"
  printf "26 zh/call_on.aac\n"
  printf "27 zh/connecting.aac\n"
  printf "28 zh/di.aac\n"
  printf "29 zh/hangup.aac\n"
  printf "30 zh/nosim.aac\n"
  printf "31 zh/op0.aac\n"
  printf "32 zh/qrcode_error.aac\n"
  printf "33 zh/reset.aac\n"
  printf "34 zh/sigerr.aac\n"
  printf "35 zh/upgrade.aac\n"
  printf "36 zh/welcome.aac\n"
  printf "37 zh/welcome_4g.aac\n"
  printf "38 zh/welcome_wifi.aac\n"
  printf "39 zh/wifi_connect_fail.aac\n"
  printf "40 zh/wifi_on.aac\n"
  printf "41 zh/wozai.aac\n"
  printf "42 nm/bind_success.aac\n"
  printf "43 nm/call_busy.aac\n"
  printf "44 nm/call_on.aac\n"
  printf "45 nm/connecting.aac\n"
  printf "46 nm/di.aac\n"
  printf "47 nm/hangup.aac\n"
  printf "48 nm/nosim.aac\n"
  printf "49 nm/op0.aac\n"
  printf "50 nm/reset.aac\n"
  printf "51 nm/sigerr.aac\n"
  printf "52 nm/upgrade.aac\n"
  printf "53 nm/welcome.aac\n"
  printf "54 nm/welcome_4g.aac\n"
  printf "55 nm/welcome_wifi.aac\n"
  printf "56 nm/wifi_connect_fail.aac\n"
  printf "57 nm/wifi_on.aac\n"
  printf "58 nm/wozai.aac\n"
  printf "q  quit\n"
  printf "Select: "
  read SEL
  case "$SEL" in
    1) F="alarm.aac" ;;
    2) F="burn_success.aac" ;;
    3) F="factesting.aac" ;;
    4) F="nocid.aac" ;;
    5) F="vcall_on.aac" ;;
    6) F="wozai.aac" ;;
    7) F="en/bind_success.aac" ;;
    8) F="en/call_busy.aac" ;;
    9) F="en/call_on.aac" ;;
    10) F="en/connecting.aac" ;;
    11) F="en/di.aac" ;;
    12) F="en/hangup.aac" ;;
    13) F="en/nosim.aac" ;;
    14) F="en/op0.aac" ;;
    15) F="en/reset.aac" ;;
    16) F="en/sigerr.aac" ;;
    17) F="en/upgrade.aac" ;;
    18) F="en/welcome.aac" ;;
    19) F="en/welcome_4g.aac" ;;
    20) F="en/welcome_wifi.aac" ;;
    21) F="en/wifi_connect_fail.aac" ;;
    22) F="en/wifi_on.aac" ;;
    23) F="en/wozai.aac" ;;
    24) F="zh/bind_success.aac" ;;
    25) F="zh/call_busy.aac" ;;
    26) F="zh/call_on.aac" ;;
    27) F="zh/connecting.aac" ;;
    28) F="zh/di.aac" ;;
    29) F="zh/hangup.aac" ;;
    30) F="zh/nosim.aac" ;;
    31) F="zh/op0.aac" ;;
    32) F="zh/qrcode_error.aac" ;;
    33) F="zh/reset.aac" ;;
    34) F="zh/sigerr.aac" ;;
    35) F="zh/upgrade.aac" ;;
    36) F="zh/welcome.aac" ;;
    37) F="zh/welcome_4g.aac" ;;
    38) F="zh/welcome_wifi.aac" ;;
    39) F="zh/wifi_connect_fail.aac" ;;
    40) F="zh/wifi_on.aac" ;;
    41) F="zh/wozai.aac" ;;
    42) F="nm/bind_success.aac" ;;
    43) F="nm/call_busy.aac" ;;
    44) F="nm/call_on.aac" ;;
    45) F="nm/connecting.aac" ;;
    46) F="nm/di.aac" ;;
    47) F="nm/hangup.aac" ;;
    48) F="nm/nosim.aac" ;;
    49) F="nm/op0.aac" ;;
    50) F="nm/reset.aac" ;;
    51) F="nm/sigerr.aac" ;;
    52) F="nm/upgrade.aac" ;;
    53) F="nm/welcome.aac" ;;
    54) F="nm/welcome_4g.aac" ;;
    55) F="nm/welcome_wifi.aac" ;;
    56) F="nm/wifi_connect_fail.aac" ;;
    57) F="nm/wifi_on.aac" ;;
    58) F="nm/wozai.aac" ;;
    q|Q) exit 0 ;;
    *) echo "invalid"; continue ;;
  esac
  echo "<SYSTEM>/app/abin/playaudio /app/res/wav/$F</SYSTEM>" | nc "$CAM" 1300
done
