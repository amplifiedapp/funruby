class Array
  def self.of(value)
    [value]
  end

  def chain(&block)
    map(&block).flatten(1)
  end
end

class Maybe
  def initialize(value)
    @value = value
  end

  def self.of(value)
    new(value)
  end

  def chain(&block)
    @value ? block.call(@value) : self
  end

  include Monad

  def to_s
    value = @value ? @value.to_s : 'nil'
    "Maybe(#{value})"
  end
end

class Future
  def initialize(celluloid_future = nil, &block)
    if block_given?
      @fut = Celluloid::Future.new(&block)
    else
      @fut = celluloid_future
    end
  end

  def self.of(value)
    new(Celluloid::Future.new { value })
  end

  def chain(&block)
    Future.new { block.call(@fut.value).value }
  end

  def value
    @fut.value
  end

  include Monad

  def to_s
    "Future(#{value})"
  end
end