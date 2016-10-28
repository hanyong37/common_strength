ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'simplecov'
SimpleCov.start

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all


  # Add more helper methods to be used by all tests here...
  def jresponse
    JSON.parse response.body
  end

  def auth_header
     {"x-api-key"=> User.first.token}
  end
  def customer_auth_header
     {"x-api-key"=> Customer.first.token}
  end


end
