require 'rails_helper'

RSpec.describe "nodes/show", type: :view do
  before(:each) do
    @node = assign(:node, Node.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
