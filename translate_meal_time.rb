# -*- coding: utf-8 -*-

#require "kconv"
#source = "example.csv"
#source = "mori_meal_time_2.csv"
#source = "hirata_meal_utf8.csv"
source = ARGV[0] or '/home/daisuke/src/sleep/machigatta.csv'
File.open(source) do |file|
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

