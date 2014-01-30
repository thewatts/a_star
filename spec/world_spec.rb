require 'spec_helper'
require './lib/world'

describe World do

  it "is created with an array" do
    world = World.new([])
    expect(world.data).to be_an Array
  end

  it "creates nodes from the input array" do
    world_data = [
      "   ",
      "   ",
      "   "
    ]
    world = World.new(world_data)

    expect(world.nodes.count).to eq 9
  end

  it "knows where the character node is" do
    world_data = [
      "   ",
      "   ",
      " C "
    ]
    world = World.new(world_data)

    expect(world.character.x).to eq 1
    expect(world.character.y).to eq 2
  end

  it "knows where the target node is" do
    world_data = [
      "   ",
      " T ",
      " C "
    ]
    world = World.new(world_data)

    expect(world.target.x).to eq 1
    expect(world.target.y).to eq 1
  end

  it "can find a node by it's coordinates" do
    world_data = [
      "   ",
      " T ",
      " C "
    ]
    world = World.new(world_data)
    node = world.node_at(1, 2)
    expect(node.x).to eq 1
    expect(node.y).to eq 2
    expect(node.character?).to be_true
  end

  it "has a current_node, that starts at the character" do
    world_data = [
      "   ",
      " T ",
      " C "
    ]
    world = World.new(world_data)
    expect(world.current_node).to eq world.character
  end

  it "has a list of open nodes, starting with the character" do
    world_data = [
      "       ",
      "   X   ",
      " C X T ",
      "   X   ",
      "       ",
    ]
    world = World.new(world_data)
    expect(world.current_node).to eq world.character
    expect(world.open_list).to eq [world.character]
  end

  it "can find the adjacent nodes from the current_node" do
    world_data = [
      "       ",
      "   X   ",
      " C X T ",
      "   X   ",
      "       ",
    ]
    world = World.new(world_data)

    diag_up_left    = world.node_at(0, 1)
    up              = world.node_at(1, 1)
    diag_up_right   = world.node_at(2, 1)
    right           = world.node_at(2, 2)
    diag_down_right = world.node_at(2, 3)
    down            = world.node_at(1, 3)
    diag_down_left  = world.node_at(0, 3)
    left            = world.node_at(0, 2)

    expected = [
      right, diag_up_right, up, diag_up_left, left,
      diag_down_left, down, diag_down_right
    ].sort_by { |node| node.f }.map do |adjacent_node|
      adjacent_node.parent = world.current_node
      adjacent_node
    end

    expect(world.current_node).to eq world.character
    expect(world.adjacent_for(world.current_node)).to eq expected
  end

  it "can find best path to the target for a simple world" do
    world_data = [
      "C  T",
    ]
    world = World.new(world_data)
    one   = world.node_at(1, 0)
    two   = world.node_at(2, 0)

    expected = [
      world.character, one, two, world.target
    ].reverse

    expect(world.evaluate).to eq expected
  end

  xit "can find best path to the target for another simple world" do
    world_data = [
      "C   ",
      "   T"
    ]
    world = World.new(world_data)
    one   = world.node_at(1, 1)
    two   = world.node_at(2, 0)

    expected = [
      world.character, one, two, world.target
    ].reverse

    expect(world.evaluate).to eq expected
  end

  xit "can find best path to the target" do
    world_data = [
      "       ",
      "   X   ",
      " C X T ",
      "   X   ",
      "       ",
    ]
    world = World.new(world_data)

    one   = world.node_at(2, 3)
    two   = world.node_at(2, 4)
    three = world.node_at(3, 4)
    four  = world.node_at(4, 4)
    five  = world.node_at(5, 3)

    expected = [
      world.character, one, two, three, four, five, world.target
    ]

    expect(world.evaluate).to eq expected
  end
end
