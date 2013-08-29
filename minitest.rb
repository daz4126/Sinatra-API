ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require_relative 'numb3rs.rb'

include Rack::Test::Methods

def app
  Sinatra::Application
end
  
describe "Factorizor" do

  it "should return the factors of 6" do
    assert_equal [1,2,3,6], 6.factors
  end
  
  it "should say that 2 is prime" do
    assert 2.prime?
  end
  
  it "should say that 10 is not prime" do
    refute 10.prime?
  end

  it "should return the factors of 6 as json" do
    get '/factors/6'
    assert_equal 6.factors.to_json, last_response.body
  end
  
  it "should return json" do
    get '/info/6'
    assert_equal last_response.headers['Content-Type'], 'application/json;charset=utf-8'
  end 
 
  it "should return info about 6 as json" do
    get '/info/6'
    six_info = { factors: 6.factors, odd: false, even: true, prime: false }
    assert_equal six_info.to_json, last_response.body
  end

end
