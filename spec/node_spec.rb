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

end

