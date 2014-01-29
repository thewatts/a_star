require './lib/world'

class Node

  attr_reader :x, :y, :value, :status, :world
  attr_accessor :parent

  def initialize(options = {}, world = World.new)
    @x      = options[:x]
    @y      = options[:y]
    @value  = options[:value]
    @status = options[:status] || "walkable"
    @world   = world
  end

  def character?
    value == "C"
  end

  def target?
    value == "T"
  end

  def walkable?
    status == "walkable"
  end

  def h
    x_diff = x - world.target.x
    y_diff = y - world.target.y
    x_diff.abs + y_diff.abs
  end
end
