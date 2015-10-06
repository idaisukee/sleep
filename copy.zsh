#!/bin/zsh
stem="$HOME/dat/sleep"
origin="$stem/origin"
dest="$stem/dest"
for i in $origin/*
do
		leaf=`ls $i -t | head -n 1`
		cp $i/$leaf/*.csv $dest
done
