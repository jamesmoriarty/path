require 'spec_helper'

class Array
  def axis_x
    self
  end

  # [
  #   [1,2,3],
  #   [0,nil,0]
  # ]
  def to_nodes
    graph = axis_x.each_with_index.map do |axis_y, x|
      axis_y.each_with_index.map do |present, y|
        Node.new if present
      end
    end
  end
end

class Node
  attr_accessor :neighbors, :visited
  alias :visited? visited

  def initialize(neighbors = [])
    @visited   = false
    @neighbors = neighbors
  end

  def visit!
    @visited = true
  end
end


def breadth_first_search(start)
  start.visit!
  open = Queue.new
  open.push(start)

  while(current = open.shift)
    current.neighbors.each do |neighbor|
      unless neighbor.visited?
        neighbor.visit!
        open.push(neighbor)
      end
    end
  end
end

describe Path do
  it 'has a version number' do
    expect(Path::VERSION).not_to be nil
  end

  subject { [[true, true, false]].to_nodes }
  it { subject[0][0].should_not be_nil }
  it { subject[0][1].should_not be_nil }
  it { subject[0][2].should be_nil }
end
