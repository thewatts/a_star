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

end
