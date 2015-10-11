require './base'


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
    else
      false
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
    else
      false
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
    else 
      false
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
    else
      false
    end

  end


  def to_s
    "#@col"
  end
end
