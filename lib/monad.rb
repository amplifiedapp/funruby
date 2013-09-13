module Monad

  def map(&block)
    chain { |value| self.class.of(block.call(value)) }
  end

  def of(value)
    self.class.of(value)
  end

  def ap(b)
    chain { |value| b.map(&value) }
  end
end