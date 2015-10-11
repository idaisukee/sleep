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


class Array
  def valid?
    self.size == 11
  end
end
