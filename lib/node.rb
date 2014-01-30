require './lib/world'

class Node

  attr_reader :x, :y, :value, :status, :world
  attr_accessor :parent

  def initialize(options = {}, world = World.new)
    @x      = options[:x]
    @y      = options[:y]
    @value  = set_value(options[:value])
    @world   = world
  end

  def character?
    value == "C"
  end

  def set_value(value)
    return "_" if value == " " || value.nil?
    value
  end

  def target?
    value == "T"
  end

  def walkable?
    value == "_" || target?
  end

  def blocked?
    !walkable?
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
    directional_score.to_i
  end

  def f
    h.to_i + g.to_i
  end

  def directional_score
    return 14 if direction == "diagonal"
    return 10 if direction == "horizontal" || direction == "vertical"
  end

  def inspect
    "<NODE: #{x}, #{y}, #{value} || G:#{g} H:#{h} F:#{f} #{parent_inspect}>"
  end

  def parent_inspect
    "parent: #{parent.x}, #{parent.y}" if parent
  end

  def path
    if parent
      [self, parent.path].flatten
    else
      [self]
    end
  end
end
