require 'rails_helper'

RSpec.feature 'Nodes management: ', type: :feature do

  before do
    login
  end

  scenario 'Shows right empty listing' do
    # right path
    expect(url).to end_with '/nodes'
    # right translation
    expect(h1.text).to have_text I18n.t(:nodes)
    # right css
    expect(table = table(class: 'nodes-list')).to be_present
    expect(create = a(class: 'nodes-action')).to be_present
    expect(sort = a(class: 'nodes-sort-action')).to be_present
    # right images - 'create.png' is visible.
    image = create.img
    expect(image).to be_present
    expect(image.src).to end_with '.png'
    expect(image.width).to eq 20
    # the list is empty
    expect(table.tbody.rows.size).to eq 0
  end

  scenario 'Create nodes' do
    expect(create = a(class: 'nodes-action')).to be_present
    create.click
    wait
    expect(url).to end_with 'nodes/new'
    expect(save = div(class: 'actions')).to be_present
    save.click
    wait
  end

  end