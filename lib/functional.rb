module Functional
  include Funkify

  auto_curry

  def add(a, b)
    a + b
  end

  def subtract(a, b)
    b - a
  end

  def div(a, b)
    a / b
  end

  def mult(a, b)
    a * b
  end

  def map(fn, obj)
    obj.map(&fn)
  end

  def mcompose(f1, f2)
    ->(value) { f1.call(value).chain(&f2) }
  end

  extend self
end

class Proc
  def **(other)
    Functional.mcompose(self, other)
  end
end