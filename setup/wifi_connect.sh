#!/bin/sh
WIFI_Device="wlan0" #Usually default
SSID="SSID" 
WIFI_Passphrase="PASSWORD"

iwctl --passphrase $WIFI_Passphrase station $WIFI_Device connect "$SSID" || (echo "WIFI failed to connect" && exit 2) #Connect to the internet.
