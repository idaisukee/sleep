#!/bin/bash
file=$1
for i in $*

do
		if $i > 1 
		then
				cat $file | sed -n -e '${i}p'
		fi
done

