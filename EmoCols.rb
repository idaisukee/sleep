require './base'

class EmoItem < String
  def initialize(string)
    @string = string
  end

  def valid?
    
    
  end

  def to_s
    "#@string"
  end
end

class EmoCols
  def initialize(lineno, cols)
    @cols = cols # Array
    @emo_items = cols.map do |emo_item|
      EmoItem.new(emo_item)
    end
  end

  def valid?

    @cols.all? {|x| x.missing? or x.valid?}
  end

  def to_s
    @cols.to_s
  end



end

