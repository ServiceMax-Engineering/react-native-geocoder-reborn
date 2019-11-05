#!/bin/sh
echo $*

firstLine=$(head -n1 $1)

if [ -z "$firstLine"  ] ;then
    commitTemplate=$(cat .commit-msg)
    echo "$commitTemplate\n $(cat $1)" > $1
fi
