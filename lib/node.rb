require './lib/world'

class Node

  attr_reader :x, :y, :value, :status, :world
  attr_accessor :parent

  def initialize(options = {}, world = World.new)
    @x      = options[:x]
    @y      = options[:y]
    @value  = options[:value]
    @world   = world
  end

  def character?
    value == "C"
  end

  def target?
    value == "T"
  end

  def walkable?
    value == " " || value == nil
  end

  def blocked?
    value != ( character? || target? || walkable? )
  end

  def coordinates
    [x, y]
  end

  def direction
    if parent
      return "diagonal"   if parent.x != x && parent.y != y
      return "horizontal" if parent.y == y
      return "vertical"   if parent.x == x
    end
  end

  def h
    x_diff = x - world.target.x
    y_diff = y - world.target.y
    (x_diff.abs + y_diff.abs) * 10
  end

  def g
    return 0 if character?
    return directional_score + parent.g if parent
    directional_score
  end

  def directional_score
    return 14 if direction == "diagonal"
    return 10 if direction == "horizontal" || direction == "vertical"
  end
end
