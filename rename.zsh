stem="$HOME/dat/sleep"
origin="$stem/origin"
dest="$stem/dest"
for i in $dest/*
do
		echo $i | sed -e 's/\_.+$//g'
done
