class Node

  attr_reader :x, :y, :value, :status
  attr_accessor :parent

  def initialize(options)
    @x      = options[:x]
    @y      = options[:y]
    @value  = options[:value]
    @status = options[:status] || "walkable"
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
end
