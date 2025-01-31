#!/usr/bin/bash

log_error()
{
    MESSAGGIO_ERRORE="$1"
    printf "[$(date)] : $MESSAGGIO_ERRORE\n" >> log_error_check_dns.txt
}

log_ok()
{
    MESSAGGIO="$1"
    printf "[$(date)] : $MESSAGGIO\n" >> log_ok_check_dns.txt
}

if [[ "$#" == "3" ||  "$#" == "4" ]]
    then
        echo "correct number of parameters"
        if [[ "$#" == "3" ]]
            then
                RECORD_DNS="A"
            else
                RECORD_DNS="$4"
fi
    else
        echo "wrong number of parameters retry-> ./check.dns.sh [HOSTNAME] [IP] [DNS_SERVER] optional [RECORD_DNS]"
        log_error "wrong number of parameters"
        exit 2
fi

if [[ "$1" =~ ^www\.[a-zA-Z0-9_-]+\.(it|com)$ ]]; then     #^www\.\w+\.(it|com)$
       echo "hostname->$1 is in a correct format"
   else
       echo "hostname->$1 is in a wrong format it must be -> www.[any].it or www.[any].com"
       log_error "first parameter is in a wrong format"
       exit 2
fi

if [[ "$2" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]  #[a-zA-Z0-9_\.-]+| controllo rimosso a causa di contrasto fra i pattern
    then
        echo "the local parameter-> $2 is in a correct format"
    else
        echo "the local parameter-> $2 is in a wrong format, correct it and retry" #[0-255].[0-255].[0-255].[0-255]
        log_error "second parameter is in a wrong format"
        exit 2
fi

if [[ "$3" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
    then
        echo "dns server-> $3 is in a correct format"
    else
        echo "dns_server-> $3 is in a wrong format it must be -> [0-255].[0-255].[0-255].[0-255]"
        log_error "third parameter is in a wrong format"
        exit 2
fi

if [[ "$RECORD_DNS" =~ ^[a-zA-Z]+[a-zA-Z\d]*$ ]]   #controllo di $4
    then
        echo "dns_record-> $RECORD_DNS is in a correct format but not necessarly correct"
    else
        echo "dns_record-> $RECORD_DNS is in a wrong format it must be it does not have spechial character"
        log_error "fourth parameter is in a wrong format"
        exit 2
fi

HOSTNAME="$1"
PARAMETRO_LOCALE="$2"
DNS_SERVER="$3"

DIG=$(dig $HOSTNAME @$DNS_SERVER $RECORD_DNS +short | tail -1)
echo "DNS RECORD -> $DIG"
echo "PARAMETRO LOCALE -> $PARAMETRO_LOCALE"
if [[ -z "$DIG" ]]    #-z "$DIG"
    then
        echo "the DNS record or the web doesn't exist"
        log_error "the DNS record or the web doesn't exist"
        exit 1
fi

if [[ "$DIG" == "$PARAMETRO_LOCALE" ]]
    then
        echo "the memorized information of the hostname->$HOSTNAME is correct"
        log_ok "the memorized information of the hostname->$HOSTNAME is correct : $DIG = $PARAMETRO_LOCALE"
        exit 0
    else
        echo "the memorized information of the hostname->$HOSTNAME is wrong"
        log_error "the memorized information of the hostname->$HOSTNAME is wrong"
        exit 1
fi

exit 3