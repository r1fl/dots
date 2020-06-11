#!/bin/sh

export MDVIEWDIR="/tmp/mdview"

# Render markdown files in browser

mkdir $MDVIEWDIR 2> /dev/null
#tmpfp=$(TMPDIR=$MDVIEWDIR mktemp)

tmpfp="/tmp/$1.html"
tmpfp="$1.html"
touch $tmpfp

pandoc --template=github.html $1 -o $tmpfp 2> /dev/null
chromium $tmpfp &>/dev/null

#sleep 5
#rm $tmpfp
