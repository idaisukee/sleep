require './base'

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
