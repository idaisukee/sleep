require 'date'
require 'time'


data = ARGV[0] || '/home/daisuke/src/sleep/machigatta.csv'

class NilClass
  def valid?
    false
  end
end

class String
  def valid?
    true
  end

  def to_s
    String.new(self)
  end

  def int?
    if self.match(/^[0-9]*$/)
      true
    end
  end

  def missing?
    if self.match(/^x$/)
      true
    end
  end

end

class MealItem < String
  def initialize(string)
    @string = string
 @string[0..3]
    @mil_time = MilTime.new(@string[0..3])
    @meal_type = @string[4]
  end

  def valid?
    if
        @mil_time.valid? and
        @meal_type.match(/^[ks]$/)
    then
      true
    else 
      false
    end
  end

  def to_s
    "#@string"
  end

end




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

class Array
  def valid?
    self.size == 11
  end
end

class Year < String
  def initialize(string)
    @string = string
  end
  def valid? 
    if
        @string.match(/^[0-9]{4}$/)
    then
      begin
        Date.new(@string.to_i, 10, 10)
        true
      rescue
        false
      end
    end
  end
   def to_s
     "#@string"
   end
end

class Month < String
  def initialize(string)
    @string = string
  end
  def valid? 
    if
        @string.match(/^[0-9]{1,2}$/)
    then
      begin
        Date.new(1000, @string.to_i, 10)
        true
      rescue
        false
      end
    end
  end
  def to_s
    "#@string"
  end
end

class Day < String
  def initialize(string)
    @string = string
  end
  def valid? 
    if
        @string.match(/^[0-9]{1,2}$/)
    then
      begin
        Date.new(1000, 10, @string.to_i)
        true
      rescue
        false
      end
    end
  end
  def to_s
    "#@string"
  end
end

class DateCol < String
  attr_accessor :s_year, :s_month, :s_day, :year, :month, :day
  def initialize(lineno, col)
    @lineno = lineno
    @col = col
    
    @s_year = @col.split('/')[0]
    @s_month = @col.split('/')[1]
    @s_day = @col.split('/')[2]
    @year = Year.new(@s_year)
    @month = Month.new(@s_month)
    @day = Day.new(@s_day)
  end

  def valid?
    if 
        [@year, @month, @day].all? {|x| x.valid?} 
    then
      begin
        Date.new(@s_year.to_i, @s_month.to_i, @s_day.to_i)

        true
      rescue
        false
      end
    end
  end

  def to_s
    "#@col"
  end

end

class SleepRange < String
  def initialize(sleep_range)
    @sleep_range = sleep_range
    @mil_times = @sleep_range.split('-').map do |x|
      MilTime.new(x)
    end
  end
  def valid?
    @sleep_range.match(/^[0-9]{4}-[0-9]{4}$/) and
    @mil_times.all? {|x| x.valid?}
  end

  def to_s
    "#@string"
  end

end

class MilTime < String
  def initialize(string)
    @string = string
    @s_hour= @string[0..1]
    @s_minute = @string[2..3]
  end
  def valid?
    if
        @string.int? and
        @string.size == 4
    then
      begin
        Time.new(1000, 10, 10, @s_hour.to_i, @s_minute.to_i)
        true
      rescue
        false
      end
    else
      false
    end
  end

  def to_s
    "#@string"
  end

end

class SleepCol < String
  def initialize(lineno, col)
    @lineno = lineno
    @col = col
    @sleep_ranges = @col.split(' ').map do |sleep_range|
      SleepRange.new(sleep_range)
    end
  end
  def valid?
    @sleep_ranges.all? {|x| x.valid?}
  end

  def to_s
    "#@col"
  end

end

class MealCol < String
  def initialize(lineno, col)
    @col = col
    @meal_items = col.split(' ').map do |meal_item|
      MealItem.new(meal_item)
    end
  end
  def valid?
    @col.missing? or
      ( @col.match(/^[0-9a-z ]{1,}$/) and
        @meal_items.all? {|x| x.valid?} )
  end

  def to_s
    "#@col"
  end

end

class EmoCols < Array
  def initialize(lineno, cols)
  end
  def valid?
    true
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

p 'string'.to_s

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
end


