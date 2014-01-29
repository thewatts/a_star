require 'spec_helper'
require './lib/node'

describe Node do

  it "has coordinates" do
    node = Node.new({ :x => 1, :y => 2 })
    expect(node.x).to eq 1
    expect(node.y).to eq 2
  end

  it "can be the character" do
    node = Node.new({ :value => 'C' })
    expect(node.value).to eq 'C'
    expect(node.character?).to be_true
  end

  it "can be the target" do
    node = Node.new({ :value => "T" })
    expect(node.value).to eq 'T'
    expect(node.target?).to be_true
  end

  it "can be walkable" do
    node = Node.new({})
    expect(node.walkable?).to be_true
  end

  it "can have a parent" do
    node        = Node.new({})
    parent_node = Node.new({})
    node.parent = parent_node

    expect(node.parent).to eq parent_node
  end

  it "has coordinates" do
    node = Node.new({x: 5, y: 4})
    expect(node.coordinates).to eq [5, 4]
  end

  it "knows the diagonal direction from the parent" do
    parent_node = Node.new({ x: 0, y: 0})
    node        = Node.new({ x: 1, y: 1 })
    node.parent = parent_node
    expect(node.direction).to eq "diagonal"
  end

  it "knows the horizontal direction from the parent" do
    parent_node = Node.new({ x: 0, y: 0})
    node        = Node.new({ x: 1, y: 0})
    node.parent = parent_node
    expect(node.direction).to eq "horizontal"
  end

  it "knows the vertical direction from the parent" do
    parent_node = Node.new({ x: 0, y: 0})
    node        = Node.new({ x: 0, y: 1})
    node.parent = parent_node
    expect(node.direction).to eq "vertical"
  end

  it "belongs to a world" do
    world = World.new
    node = Node.new({}, world)

    expect(node.world).to eq world
  end

  describe "scores" do

    it "has an H score (distance from Target)" do
      world_data = [
        "    ",
        "   T"
      ]
      world = World.new(world_data)
      node = world.node_at(0,0)
      expect(node.h).to eq 40
    end

    it "has a G score (G cost from parent + direction cost)" do
      parent_node = Node.new({ x: 0, y: 0, value: 'C'}) # starting node
      node        = Node.new({ x: 0, y: 1})
      node.parent = parent_node
      expect(node.g).to eq 10
    end

    it "has a G score, 2 nodes from the character" do
      character          = Node.new({ x: 0, y: 0, value: 'C'})
      parent_node        = Node.new({ x: 1, y: 0 })
      node               = Node.new({ x: 3, y: 1})
      parent_node.parent = character
      node.parent        = parent_node

      expect(parent_node.g).to eq 10
      expect(node.g).to eq 24
    end

    it "has an F score (distance from Char by path + distance from T)" do
      world_data = [
        "C   ",
        "    ",
        "   T"
      ]
      world               = World.new(world_data)
      node                = world.node_at(2, 2)
      parent_node         = world.node_at(2, 1)
      parents_parent_node = world.node_at(1, 0)
      character           = world.character

      node.parent                = parent_node
      parent_node.parent         = parents_parent_node
      parents_parent_node.parent = character

      expect(node.h).to eq 10
      expect(node.g).to eq 34
    end

  end

end

