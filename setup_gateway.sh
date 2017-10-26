#!/bin/bash
interfaces=$(ls /sys/class/net | grep -v lo)

forwardLocalToGlobal() {
        LAN=$0
        WAN=$1
	sudo iptables -t nat -A POSTROUTING -o $WAN -j MASQUERADE
	sudo iptables -A FORWARD -i $LAN -o $WAN -m state --state RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A FORWARD -i $LAN -o $WAN -j ACCEPT
}

# https://unix.stackexchange.com/a/111517
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 INTERNAL_INTERFACE EXTERNAL_INTERFACE" >&2
  exit 1
fi
# https://stackoverflow.com/questions/9057387/process-all-arguments-except-the-first-one-in-a-bash-script
for i in "${@:1}"; do
  echo "$i is not a valid interface!"
  exit 1
done

forwardLocalToGlobal $0 $1
