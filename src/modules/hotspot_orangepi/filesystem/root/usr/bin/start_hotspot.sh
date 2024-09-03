#!/usr/bin/env bash
#because it takes some time before the wifi is up and able to detect networks
sleep 30

if [[ -e /etc/wpa_supplicant/wpa_supplicant.conf ]]
then
  #get info from wpa_supplicant
  SSID=`grep -E "^\s+ssid" /etc/wpa_supplicant/wpa_supplicant.conf | sed 's/^[[:space:]]*//g' | cut -c 7- | sed 's/.$//'`
  #PASSWORD=`grep -E "^\s+#psk" /etc/wpa_supplicant/wpa_supplicant.conf | sed 's/^[[:space:]]*//g' | cut -c 6-`
  PASSWORD=`grep -E "^\s+psk" /etc/wpa_supplicant/wpa_supplicant.conf | sed 's/^[[:space:]]*//g' | cut -c 5-`
  echo "preparing to connect to wifi with SSID: '${SSID}' and password: '${PASSWORD}'"
  nmcli dev wifi connect "${SSID}" password "${PASSWORD}"
fi

#if wifi is not connected
ip link show dev wlan0 | grep -q "state UP"
check=$?
if [ "$check" -ne 0 ]
then
  echo "starting RatOS hotspot"
  /usr/bin/create_ap --config /etc/create_ap.conf
fi