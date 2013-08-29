ENV['RACK_ENV'] = 'test'

require_relative 'numb3rs.rb'

require 'test/unit'
require 'rack/test'

class FactorsTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
  
  def test_factors_method
    assert_equal [[1,6],[2,3]], 6.factors
  end
  
  def test_get_factors
    get '/factors/6'
    assert last_response.ok?
    assert_equal 6.factors.to_json, last_response.body
  end
end
