i=1
CONTATORE_ERRORE=0
CHECK_DNS=""
for i in {1..10} ;  do
    CHECK_DNS=$(./check_dns.sh "www.italia.it" "10.10.10.10" "8.8.8.8")
    #echo "$CHECK_DNS"
    CODICE_USCITA=$?
    #echo $CODICE_USCITA
    if [[ "$CODICE_USCITA" == "1" ]]
        then
            let CONTATORE_ERRORE=$CONTATORE_ERRORE+1
            #echo "$CONTATORE_ERRORE"
        else
            let CONTATORE_ERRORE=0
    fi
    if [[ "$CONTATORE_ERRORE" == "3" ]]
        then
            CHECK_DNS=$(echo "$CHECK_DNS" | tail -1) #tail -1 <<<
            #echo "$CHECK_DNS"
            ./send_telegram_message.sh "errore in check_dns.sh->$CHECK_DNS"
    fi
done
exit 0