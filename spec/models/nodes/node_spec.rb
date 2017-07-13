require 'rails_helper'

module Nodes
  RSpec.describe Node, type: :model do
    let(:node)  { create :nodes_node }

    it 'has a valid factory'  do
      expect(node).to be_valid
    end

    it 'has a valid build factory'  do
      expect(build(:nodes_node)).to be_valid
    end

    it 'is invalid without a name' do
      expect(build(:nodes_node, name: nil)).not_to be_valid
    end
  end
end
