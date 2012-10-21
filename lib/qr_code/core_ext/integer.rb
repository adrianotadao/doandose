class Integer
  def rszf(count)
    (self >> count) & ((2 ** ((self.size * 8) - count))-1)
  end
end
