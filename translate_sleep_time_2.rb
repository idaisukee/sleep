# -*- coding: utf-8 -*-
require 'date'

class String
  def hour
    self[0..1].to_i
  end
  def min
    self[2..3].to_i
  end
end

class Range
  def each_10_min
    @i = self.first
    until @i > self.last
      yield @i
      @i += 10 * 60  # 10 mins
    end
  end
end
    
$true_awake_ranges = Array.new

data = ARGV[0] || '/home/daisuke/dat/sleep/origin/ikeda/2/yamaguchi.csv'
File.open(data) do |file|
  file.each do |line|
    full_date = line.split(",")[0]
    year = full_date.split("/")[0].to_i
    month = full_date.split("/")[1].to_i
    date = full_date.split("/")[2].to_i
    true_full_date = Date.new(year, month, date)
    time_cell = line.split(",")[1].strip
    # => "0900-1000 1300-2000"
    awake_ranges = time_cell.split(" ")
    # => ["0900-1000", "1300-2000"]

    awake_ranges.each do |awake_range|
      digital = awake_range.split("-")
      start = digital[0]
      finish = digital[1]
      true_start = Time.local(year, month, date, start.hour, start.min)
      true_finish = Time.local(year, month, date, finish.hour, finish.min) - 10 * 60
      $true_awake_ranges << Range.new(true_start, true_finish)
    end
    


  end
end

File.open(data) do |file|
  file.each do |line|
    full_date = line.split(",")[0]
    year = full_date.split("/")[0].to_i
    month = full_date.split("/")[1].to_i
    date = full_date.split("/")[2].to_i
    start = Time.local(year, month, date, 0, 0)
    finish = Time.local(year,month, date, 24, 0)
    one_day = Range.new(start, finish)
    one_day.each_10_min do |time|

      if $true_awake_ranges.any? do |range|
          range.cover?(time)
        end
        active = 1
        else
        active = 0
      end
      print time.strftime("%Y/%m/%d,%H:%M,"), active, "\n"

    end
  end
  
end

