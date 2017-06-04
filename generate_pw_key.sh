#!/bin/bash

# 참고: http://www.myservlab.com/176

ENC_FILE=zzz_key.enc


read -s -p "변경할 password를 입력하세요: " NEWPW
echo


PLAIN_FILE=zzz_key.txt
echo $NEWPW > $PLAIN_FILE


# Create private & public key

PRIVATE_KEY=private_key.pem
PUBLIC_KEY=public_key.pem

if [ ! -e $PRIVATE_KEY ]; then
    openssl genrsa -out $PRIVATE_KEY 1024
fi

if [ ! -e $PUBLIC_KEY ]; then
    openssl rsa -in $PRIVATE_KEY -out $PUBLIC_KEY -outform PEM -pubout
fi


# Encrypt password file
openssl rsautl -encrypt -inkey $PUBLIC_KEY -pubin -in $PLAIN_FILE -out $ENC_FILE


# Decrypt password file
echo "새로운 password를 encrypt & decrypt한 결과: " $(openssl rsautl -decrypt -inkey $PRIVATE_KEY -in $ENC_FILE)
echo


rm $PLAIN_FILE
