$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'api_coder'
require 'shoulda-matchers'
require 'rack/test'
require 'rack/api_coder'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end

RSpec.configure do |config|
  config.after(:each) do
    APICoder.enums.clear
    APICoder.routes.clear
  end
end
