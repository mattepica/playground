#!/usr/bin/bash

GROUP_ID=-1002327066111
BOT_TOKEN=7919864220:AAFwFEo7VJwMvH5xXEXx_358DHKuDRYB9BM
curl -s --data "text=$1" --data "chat_id=$GROUP_ID" 'https://api.telegram.org/bot'$BOT_TOKEN'/sendMessage' > /dev/null
CODICE_ERR=$?
if [[ "$CODICE_ERR" != "0" ]]
    then
        echo "fallito invio del messaggio" >&2
fi
#-1002327066111
#7919864220
#7919864220:AAFwFEo7VJwMvH5xXEXx_358DHKuDRYB9BM