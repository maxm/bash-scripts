#!/bin/bash

function timer() {
    if [[ $# -eq 0 ]]; then
        echo $(date '+%s')
    else
        local  stime=$1
        etime=$(date '+%s')

        if [[ -z "$stime" ]]; then stime=$etime; fi

        dt=$((etime - stime))
        ds=$((dt % 60))
        dm=$(((dt / 60) % 60))
        dh=$((dt / 3600))
        printf '%d:%02d:%02d' $dh $dm $ds
    fi
}

function timeout() {
    echo o `date '+%Y-%m-%d %H:%M:%S'` >>$TIMELOG
    echo -e '\nDone'
}

printToday() { echo "Today:" $1; }
printToday `ledger -f $TIMELOG -p today bal | tail -n 1`

echo i `date '+%Y-%m-%d %H:%M:%S'` $* >>$TIMELOG
trap "exit" SIGTERM SIGINT
trap timeout EXIT

start=$(timer)
until read -est 1; do
    echo -en "\r"$*":" $(timer $start)
done
