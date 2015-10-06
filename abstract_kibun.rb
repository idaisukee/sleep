# -*- coding: utf-8 -*-
date_cell_position = 0
leftest_kibun_position = 3
data = ARGV[0] || '/home/daisuke/src/sleep/machigatta.csv' # || は = よりも優先順位が上．

if ARGV[1] == '1' 
  factor = 13.5
else
  factor = 1.0
end

File.open(data) do |file|
  file.each_line do |line|
    cols = line.chomp.split(",")
    kibuns = cols[leftest_kibun_position..-1].map do |elem|
      if elem == "x" then
        elem
      else
        (elem.to_f * factor).round
      end
    end
    print cols[date_cell_position], ",", kibuns.join(","), "\n"
  end
end
