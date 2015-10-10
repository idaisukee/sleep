require 'date'

data = ARGV[0] || '/home/daisuke/src/sleep/machigatta.csv'

def err(err_type)
  puts err_type
end

class Day
  attr_accessor :date, :sleep, :meal, :emos, :errors
  def initialize(cols)
    @date = cols[0]
    @sleep = cols[1]
    @meal = cols[2]
    @emos = cols[3..-1]
    @errors = Array.new
  end

  def test
    self.date.test_date
    self.sleep.test_sleep
    self.meal.test_meal
    self.emos.test_emos
  end
end

class Array
  def test_cols
    if self.size == 1
      true
    else
      false
    end
  end

  def test_emos
  end

end

class String
  def test_date
    year = self.split('/')[0]
    month = self.split('/')[1]
    day = self.split('/')[2]

    year.test_year
    month.test_month
    day.test_month
  end

  def test_sleep
  end

  def test_meal
  end

  def test_year
    unless self.size == 4 
      err('year_size')
    end
    unless self.is_num
      err('year_non_num')
    end

  end

  def test_month
  end

  def test_day
  end

  def is_num
    if self.match(/^[0-9]*$/)
      true
    else
      false
    end
  end
end

records = Array.new
File.open(data) do |file|
  file.each do |line|
    cols = line.chomp.split(',')
    cols.test_cols
    records << Day.new(cols)
  end
end

records.each do |record|
  record.test
end
