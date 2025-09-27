#!/bin/bash


echo "check first command-line argument and take appropriate action..."

case $1 in
    no|yes) response=1;;
    -[tT])  table=TRUE;;
    *)      echo "unknown option"; exit 1;;
esac

while :
do
    printf "Type . to finis ==> "
    read line
    case "$line" in
        .) echo "Message done"
           break ;;
        *) echo "$line" >> $message ;;
    esac
done
