require 'date'
require 'time'

require './DateCol'
require './SleepCol'
require './MealCol'
require './EmoCols'

data = ARGV[0] || '/home/daisuke/src/sleep/machigatta.csv'


class Record
  attr_accessor :lineno, :date_col, :sleep_col, :meal_col, :emo_cols, :errors

  def initialize(lineno, date_col, sleep_col, meal_col, emo_cols)
    @lineno = lineno
    @date_col = date_col
    @sleep_col = sleep_col
    @meal_col = meal_col
    @emo_cols = emo_cols
    @errors = Array.new
  end

  def valid?
    [@date_col, @sleep_col, @meal_col, @emos_cols].all? {|x| x.valid?}
  end
end


records = Array.new
File.open(data) do |file|
  file.each do |line|
    cols = line.chomp.split(',')
    date_col = DateCol.new(file.lineno, cols[0])
    sleep_col = SleepCol.new(file.lineno, cols[1])
    meal_col = MealCol.new(file.lineno, cols[2])
    emo_cols = EmoCols.new(file.lineno, cols[3..-1])
    records << Record.new(file.lineno, date_col, sleep_col, meal_col, emo_cols)
  end
end
# p Year.new('100a').valid?
# p Month.new('10').valid?
# p Day.new('10').valid?
# p DateCol.new(1, '1000/10/10').valid?

# d = Day.new('12')
# p d.to_i
# s = '1000/10/10'
# e = DateCol.new(1, s)
# p e.s_day.to_i

records.each do |record|
  puts [record.lineno, record.valid?, record.date_col.valid?, record.sleep_col.valid?, 
        record.meal_col.valid?, record.emo_cols.valid?].join(' ')
  puts [record.date_col.to_s, record.date_col.valid?].join(' ')
  puts [record.date_col.year.to_s, record.date_col.year.valid?].join(' ')
  puts [record.date_col.month.to_s, record.date_col.month.valid?].join(' ')
  puts [record.date_col.day.to_s, record.date_col.day.valid?].join(' ')
  puts
  puts [record.sleep_col.to_s, record.sleep_col.valid?].join(' ')
  puts
  puts [record.meal_col.to_s, record.meal_col.valid?].join(' ')
  puts
  puts [record.emo_cols.to_s, record.emo_cols.valid?].join(' ')
end


