# -*- coding: utf-8 -*-

#require "kconv"

=begin
山中先生の仕事のための script.
## 入力
```
日附,食事時刻と種別,...
2015/10/5,1200s 1600k,...
2015/10/6,1230s,...
```

## 出力
```
日附,食事時刻,間食記號
2015/10/5,12
,16,L
2015/10/6,12.5
```
=end

data = ARGV[0] || '/home/daisuke/src/sleep/machigatta.csv' # || は = よりも優先順位が上．
File.open(data) do |file|
  file.each_line do |line|
    date_cell = line.split(",")[0] # 0列目を取出す．
    time_and_type_cell = line.split(",")[1].strip # 1列目を取り出す．
    times_and_types = time_and_type_cell.split(" ")
    # => ["1230s", "1545k", "1650s"]

    if time_and_type_cell == "" then
      # 缺損値のとき
      print date_cell, ",,\n"
    end

    times_and_types.each_with_index do |time_and_type, index|
      hour = time_and_type.split("")[0..1].join # => "12"
      minute = time_and_type.split("")[2..3].join # => "30"
      decimal_minute = (minute.to_f / 60.0).round(2) # => .5
      type = time_and_type.split("")[4] # => "s"
      
      if index == 0 then
        print date_cell
      end

      print ","
        
      print hour.to_f + decimal_minute

      print ","

      if type == "k" then
        print "L"
      end

      print "\n"


    end
  end
end

