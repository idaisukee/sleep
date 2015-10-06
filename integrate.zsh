#!/bin/zsh

stem="$HOME/dat/sleep"
origin="$stem/origin"
dest="$stem/dest"
prod="$stem/prod"
src_dir="$HOME/src/sleep"

for i in $dest/*.csv
do

		ruby $src_dir/validate.rb $i

		if [ $i:t = 'inoue.csv' ]
		then
				flag=0
		else
				flag=1
		fi
		base=$i:t:r
		ruby $src_dir/translate_meal_time.rb $i > $prod/${base}_meal.csv
		ruby $src_dir/translate_sleep_time_2.rb $i > $prod/${base}_sleep.csv
		ruby $src_dir/abstract_kibun.rb $i $flag > $prod/${base}_kibun.csv
done
