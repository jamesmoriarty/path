require 'spec_helper'

class Array
  def axis_x
    self
  end

  def to_nodes
    graph = axis_x.each_with_index.map do |axis_y, x|
      axis_y.each_with_index.map do |weight, y|
        Node.new(x, y) if weight
      end
    end

    graph.each_with_index do |axis_y, x|
      axis_y.each_with_index do |node, y|
        next unless node

        [
          [ 0, -1], # up
          [ 1,  0], # right
          [-1,  0], # left
          [ 0,  1]  # down
        ].each do |offset_x, offset_y|
          current_x = x + offset_x
          if 0 <= current_x && graph[current_x]
            current_y = y + offset_y
            if 0 <= current_y && neighbor = graph[current_x][current_y]
              next if neighbor == node
              node.neighbors << neighbor
            end
          end
        end
      end
    end
  end
end

class Node
  attr_accessor :neighbors, :visited, :from, :distance, :x, :y
  alias :visited? visited

  def initialize(x = nil, y = nil, from = nil, distance = 0, neighbors = [])
    @x, @y     = x, y
    @visited   = false
    @from      = from
    @distance  = distance
    @neighbors = neighbors
  end

  def visit!
    @visited = true
  end

  def self.breadth_first_search(start)
    start.visit!
    open = Array.new
    open.push(start)

    while(current = open.shift)
      current.neighbors.each do |neighbor|
        unless neighbor.visited?
          neighbor.visit!
          neighbor.from     = current
          neighbor.distance = current.distance + 1
          open.push(neighbor)
        end
      end
    end
  end
end



describe Path do
  it 'has a version number' do
    expect(Path::VERSION).not_to be nil
  end

  describe Node do
    subject(:node) { described_class.new }

    describe "#visited?" do
      it { subject.visited?.should eq false }
    end

    describe "#visit!" do
      it { subject.visit!; subject.visited?.should eq true }
    end

    describe ".breadth_first_search" do
      context "no neighbors" do
        let(:nodes) { [[true, false, true]].to_nodes }

        subject { Node.breadth_first_search(nodes[0][0]) }

        before { subject }

        it { nodes[0][0].visited.should eq true }
        it { nodes[0][2].visited.should eq false }
      end

      context "1 neighbor" do
        let(:nodes) { [[true, true, true]].to_nodes }

        subject { Node.breadth_first_search(nodes[0][0]) }

        before { subject }

        it { nodes[0][0].visited.should eq true }
        it { nodes[0][0].distance.should eq 0 }
        it { nodes[0][1].visited.should eq true }
        it { nodes[0][1].distance.should eq 1 }
        it { nodes[0][2].visited.should eq true }
        it { nodes[0][2].distance.should eq 2 }
      end

    end
  end

  describe Array do
    describe "#to_nodes" do
      subject(:nodes) { [[true, true, false]].to_nodes }

      it { subject[0][0].should_not be_nil }
      it { subject[0][0].neighbors.size.should eq 1 }
      it { subject[0][0].neighbors.first.should eq subject[0][1] }
      it { subject[0][1].should_not be_nil }
      it { subject[0][1].neighbors.size.should eq 1 }
      it { subject[0][1].neighbors.first.should eq subject[0][0]  }
      it { subject[0][2].should be_nil }
    end
  end
end
