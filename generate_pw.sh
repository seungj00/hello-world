#!/bin/bash

# 참고: http://bahndal.egloos.com/422524

read -p "변경할 password를 입력하세요: " NEWPW

PLAIN_FILE=zzz.txt
echo $NEWPW > $PLAIN_FILE
ENC_FILE=zzz.enc

echo -n "$NEWPW" | openssl aes-256-cbc -in $PLAIN_FILE -pass stdin > $ENC_FILE
echo -n "$NEWPW" | openssl aes-256-cbc -d -in $ENC_FILE -pass stdin

rm $PLAIN_FILE
