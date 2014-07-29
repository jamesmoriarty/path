require "spec_helper"

describe Path do
  it 'has a version number' do
    expect(Path::VERSION).not_to be nil
  end

  describe Node do
    subject(:node) { described_class.new }

    describe ".bf_search" do
      context "no neighbors" do
        let(:nodes) { [[true, false, true]].to_nodes }

        subject { Node.bf_search(nodes[0][0]) }

        before { subject }

        it { subject[nodes[0][0]].should eq 0 }
        it { subject[nodes[0][2]].should eq nil }
      end

      context "2 neighbors" do
        let(:nodes) { [[true, true, true]].to_nodes }

        subject { Node.bf_search(nodes[0][0]) }

        before { subject }

        it { subject[nodes[0][0]].should eq 0 }
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

        subject { Node.bf_search(nodes[0][0]) }

        it { nodes.each { |row| pp row.map { |node| subject[node]} } }
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
