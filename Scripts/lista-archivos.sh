#!/bin/bash
# Script para la creacion de listas con archivos de la ultima semana y mes.
# Manuel Moscoso Dominguez
# 11-07-2014
DIRECTORY_LOG="/home/plataforma/LOG_ASA/"
DIRECTORY_FILE_WEEK="/var/www/config_logs/SEMANA.txt"
DIRECTORY_FILE_MONTH="/var/www/config_logs/MES.txt"
WEEK=7
MONTH=30

if [ ! -f "$DIRECTORY_FILE_WEEK" ] ; then
    # if not create the file
    echo "Creating FILE_WEEK"
    touch "$DIRECTORY_FILE_WEEK"
fi
if [ ! -f "$DIRECTORY_FILE_MONTH" ] ; then
    # if not create the file
    echo "Creating FILE_MONTH"
    touch "$DIRECTORY_FILE_MONTH"
fi

printf "" > "$DIRECTORY_FILE_WEEK"
printf "" > "$DIRECTORY_FILE_MONTH"

###
DATE="$(date +'%Y-%m-%d')"

for i in $(seq 0 1 $WEEK)
do
    PREV_DATE=$(date +%Y%m%d -d "$DATE - $i day")
    RESULT="$(ls $DIRECTORY_LOG | grep $PREV_DATE)"
    arrRES=(${RESULT// /})
    for i in "${arrRES[@]}"; do
        printf "%s\n" $i >> "$DIRECTORY_FILE_WEEK"
    done   
done

###

for i in $(seq 0 1 $MONTH)
do
    PREV_DATE=$(date +%Y%m%d -d "$DATE - $i day")
    RESULT="$(ls $DIRECTORY_LOG | grep $PREV_DATE)"
    arrRES=(${RESULT// / })
    for i in "${arrRES[@]}"; do
        printf "%s\n" "$i" >> "$DIRECTORY_FILE_MONTH"
    done
done
###


#chown plataforma.plataforma "$DIRECTORY_FILE_WEEK"
#chown plataforma.plataforma "$DIRECTORY_FILE_MONTH"

