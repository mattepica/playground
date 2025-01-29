#!/bin/bash

HOSTNAME="$1"
IP="$2"
DNS_SERVER="$3"

DIG=$(dig $HOSTNAME @$DNS_SERVER +short | tail -1)

if [[ "$DIG" == "$IP" ]]
    then
        echo "Ip corretto"
        exit 0
    else
        echo "Ip errato"
        exit 1
fi

exit 3