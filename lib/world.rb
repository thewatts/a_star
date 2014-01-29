require './lib/node'

class World

  attr_reader :data

  def initialize(input_data = [])
    @data = input_data
  end

  def nodes
    @nodes ||= nodes_from_data
  end

  def character
    nodes.find { |node| node.character? }
  end

  def target
    nodes.find { |node| node.target? }
  end

  def node_at(x, y)
    nodes.find { |node| node.x == x && node.y == y }
  end

  private

  def nodes_from_data
    data.map.with_index do |row, y|
      row.chars.map.with_index do |node_value, x|
        Node.new({x: x, y: y, value: node_value}, self)
      end
    end.flatten
  end
end
