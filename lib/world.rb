require './lib/node'

class World

  attr_reader :data, :open_list
  attr_accessor :current_node

  def initialize(input_data = [])
    @data         = input_data
    @current_node = character
    @open_list    = [character]
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

  def adjacent_for(node)
    nodes.find_all do |candidate|
      x_off_by_1?(node, candidate) && same_y?(node, candidate) ||
      y_off_by_1?(node, candidate) && same_x?(node, candidate) ||
      x_off_by_1?(node, candidate) && y_off_by_1?(node, candidate)
    end.sort_by { |adjacent_node| adjacent_node.f }
  end

  private

  def y_off_by_1?(node, candidate)
    node.y - 1 == candidate.y ||
    node.y + 1 == candidate.y
  end

  def x_off_by_1?(node, candidate)
    node.x - 1 == candidate.x ||
    node.x + 1 == candidate.x
  end

  def same_y?(node, candidate)
    node.y == candidate.y
  end

  def same_x?(node, candidate)
    node.x == candidate.x
  end

  def nodes_from_data
    data.map.with_index do |row, y|
      row.chars.map.with_index do |node_value, x|
        Node.new({x: x, y: y, value: node_value}, self)
      end
    end.flatten
  end
end
