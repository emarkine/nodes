require 'rails_helper'

RSpec.feature 'User management: ', type: :feature do

  before do
    login
  end

  scenario 'Shows profile data' do
    expect(url).to end_with '/profile'
    # expect(div(class: 'notice').text).to 'Login successful'
  end


end