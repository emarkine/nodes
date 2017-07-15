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
    expect(table = table(class: 'nodes-lst')).not_to be_nil
    puts table
#    'create.png' is visible.
  end

  end