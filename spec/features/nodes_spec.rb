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
    # right images
#    'create.png' is visible.
  end


end