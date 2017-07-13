module TestHelpers
  module Features
    URL = 'localhost:3001'
    def login
      user = User.find_by_name 'Test'
      login_user(user, 'password')
    end
    def login_user(user, password)
      goto "#{URL}/login"
      text_field( id: 'email').set 'test@marketram.com'
      text_field( id: 'password').set 'password'
      button(text: 'login').click
      wait
    end
  end
end

RSpec.configure do |config|
  config.include TestHelpers::Features, type: :feature
end

