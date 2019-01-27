#!/bin/sh

if [[ $# -lt 2 ]]; then 
	echo "usage: $0 <domain> <audiodev>"
	exit 1
fi

DOMAIN=$1
AUDIODEV=$2
VIRSH='virsh -c qemu:///system'

function bash_main() {

	
	if [[ ! $($VIRSH list --all | grep $DOMAIN) ]]; then
		echo "domain $DOMAIN wasn't found"
		exit 1
	fi

	if [[ ! $($VIRSH list | grep $DOMAIN) ]]; then
		echo "[*] starting $DOMAIN"
		$VIRSH start $DOMAIN
	fi

	VENDPROD=$(lsusb | grep $AUDIODEV | awk '{ print $6 }')
	VENDOR=0x$(echo $VENDPROD | cut -d':' -f1)
	PRODUCT=0x$(echo $VENDPROD | cut -d':' -f2)

	DEVFILE=$(mktemp)
	echo "[*] device file at '$DEVFILE'"

	echo "<hostdev mode='subsystem' type='usb' managed='yes'>" >> $DEVFILE
	echo "	<source>" >> $DEVFILE
	echo "		<vendor id='$VENDOR'/>" >> $DEVFILE
	echo "		<product id='$PRODUCT'/>" >> $DEVFILE
	echo "	</source>" >> $DEVFILE
	echo "</hostdev>" >> $DEVFILE

	CURXML=$($VIRSH dumpxml $DOMAIN)
	if [[ $(echo $CURXML | grep -e "vendor.*$VENDOR") ]]; then
		if [[ $(echo $CURXML | grep -e "product.*$PRODUCT") ]]; then
			echo "[*] detaching device '$AUDIODEV'"
			$VIRSH detach-device $DOMAIN $DEVFILE

			echo "[*] shutting down synergy"
			killall -KILL synergys

			return 0
		fi
	fi

	echo "[*] (re)starting synergy"
	pkill synergys
	nohup nice -n -10 synergys -f --no-tray --debug 'ERROR' --name 'DESKTOP-ALH8NSA' -c "$XDG_CONFIG_HOME/synergy.conf" --address "192.168.122.1:24800" &> /dev/null &

	echo "[*] attaching device '$AUDIODEV'"
	$VIRSH attach-device $DOMAIN $DEVFILE
}

bash_main
echo "[*] removing '$DEVFILE'"
rm $DEVFILE

