require "spec_helper"

describe Path do
  it 'has a version number' do
    expect(Path::VERSION).not_to be nil
  end

  describe Node do
    subject(:node) { described_class.new }

    describe ".bf_search" do
      let(:target) { nodes[0][0] }

      context "no neighbors" do
        let(:nodes) { [[true, false, true]].to_nodes }

        subject { Node.bf_search(target) }

        before { subject }

        it { subject[target].should eq 0 }
        it { subject[nodes[0][2]].should eq nil }
      end

      context "2 neighbors" do
        let(:nodes) { [[true, true, true]].to_nodes }

        subject { Node.bf_search(target) }

        before { subject }

        it { subject[target].should eq 0 }
        it { subject[nodes[0][1]].should eq 1 }
        it { subject[nodes[0][2]].should eq 2 }
      end

      context "maze" do
        let(:nodes) do
          [
            [true, false, true, true],
            [true, true,  true, false]
          ].to_nodes
        end

        subject { Node.bf_search(target) }

        it { nodes.transpose.each { |row| pp row.map { |node| subject[node]} } }

        it do
          infinity = Float::INFINITY
          current  = nodes[0][3]
          finish   = target

          while(current != finish) do
            current = current.neighbors.min do |node|
              subject[node] || infinity
            end
          end
        end
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
