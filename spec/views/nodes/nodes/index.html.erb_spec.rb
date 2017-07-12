require 'rails_helper'

RSpec.describe "nodes/index", type: :view do
  before(:each) do
    assign(:nodes, [
      Node.create!(
        :name => "Name"
      ),
      Node.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of nodes" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
