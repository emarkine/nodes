RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  Faker::Config.locale = :en
end

