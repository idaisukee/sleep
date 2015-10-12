#!/bin/zsh
stem="$HOME/dat/sleep"
origin="$stem/origin"
dest="$stem/dest"
for i in $origin/*
# origin の下に tanaka とか yamada といふ dir (擔當者ごと) があり，
# さらにその下に 1 とか 2 とかといふ dir (何囘めの提出かを示す) がある，
# といふ想定．
do
		leaf=`ls $i -t | head -n 1`
		# 最新の提出を相手にする．
		# ls の -t は更新時刻の順に竝べる option.
		cp $i/$leaf/*.csv $dest
done
