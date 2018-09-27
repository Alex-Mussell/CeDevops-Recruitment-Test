#!/bin/bash

echo Using signature from /tmp/signingKey
cat /tmp/signingKey

cp $1 $1-signed.txt
echo This super secure build was signed at `date +"%Y-%m-%d-%H-%M"` with key `cat /tmp/signingKey` >> $1-signed.txt
