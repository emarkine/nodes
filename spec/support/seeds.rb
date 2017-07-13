RSpec.configure do |config|
  config.before(:suite) do
    Rails.application.load_seed # loading seeds
  end
end