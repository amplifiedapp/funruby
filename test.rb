require 'rubygems'
require 'bundler/setup'
require './lib/all'

include Functional

class << self
  include Funkify

  def log(value)
    puts value
  end

  auto_curry :log
end

log map(add(3), [1, 2, 3]).inspect
log map(add(3), Maybe.new(2))
log map(add(3), Maybe.new(nil))

log Maybe.of(add(3)).ap(Maybe.new(4))
log Maybe.of(8).map(&add).ap(Maybe.new(5))
log Maybe.of(nil).map(&add).ap(Maybe.new(5))
log Maybe.of(8).map(&add).ap(Maybe.new(nil))

fut = map add(3), Future.new { sleep 1; 4 }
fut = map subtract(4), fut
fut = map add(10), fut
fut = map mult(3), fut
log map(log, fut).inspect


work = mult(3) * add(10) * subtract(4) * add(3)
fut = map work, Future.new { sleep 1; 4 }
log map(log, fut).inspect


move_knight = ->(pos) do
  c, r = pos
  [
    [c+2,r-1],[c+2,r+1],[c-2,r-1],[c-2,r+1],
    [c+1,r-2],[c+1,r+2],[c-1,r-2],[c-1,r+2]
  ].select { |_c, _r| (1..8).include?(_c) && (1..8).include?(_r) }
end

in3 = ->(pos) { [pos].chain(&(move_knight ** move_knight ** move_knight)) }

puts in3.([6, 2]).inspect

sleep 2