$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'api_coder'
require 'shoulda-matchers'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end
