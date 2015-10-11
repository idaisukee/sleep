require './base'

class SleepCol < String
  def initialize(lineno, col)
    @lineno = lineno
    @col = col
    @sleep_ranges = @col.split(' ').map do |sleep_range|
      SleepRange.new(sleep_range)
    end
  end
  def valid?
    @col.missing? or
    @sleep_ranges.all? {|x| x.valid?}
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
      @mil_times[0].to_t < @mil_times[1].to_t and
      @mil_times.all? {|x| x.valid?}
  end

  def to_s
    "#@string"
  end

end

