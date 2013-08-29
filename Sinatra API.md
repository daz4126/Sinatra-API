Based on this brilliant video http://ascii.io/a/4348

create numb3rs.rb

require 'sinatra'
require 'json'

class Integer
  def factors
    square_root = self**0.5
    (1..square_root).map{ |n| [n,self/n] if self/n*n == self }.compact.flatten.sort
  end
  
  def prime?
    self.factors.size == 2 ? true : false
  end
end
  

get '/factors/:number' do
  content_type :json
  number = params[:number].to_i
  factors = number.factors
  factors.to_json
end

get '/numb3rs/:number' do
  content_type :json
  number = params[:number].to_i
  info = {
      :factors => number.factors,
      :prime => number.prime?,
      :odd => number.odd?,
      :even => number.even?
  }
  info.to_json
end

ruby numb3rs.rb

visit 'http://localhost:4567/factors/12'
1,2,3,4,6,12

curl http://localhost:4567/factors/12

Version Control with Git

git init
git add .
git commit -m 'factors API'

Add to Github



Testing
------------

create test.rb

    ENV['RACK_ENV'] = 'test'

    require_relative 'main.rb'

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
    

$ ruby test.rb
Run options: 

# Running tests:

Finished tests in 0.082730s, 24.1751 tests/s, 36.2626 assertions/s.
2 tests, 3 assertions, 0 failures, 0 errors, 0 skips


git add .
git commit -m 'added test'


Bundler
------------------
Create Gemfile

    source 'https://rubygems.org'
    gem "sinatra"
    gem "json"
    gem "rack-test", :group => :test

$ bundle install

Launch on Heroku
--------------------
Create config.ru

  require './main'
  run Sinatra::Application

Test it
  
$ bundle exec rackup
[2013-08-29 13:27:36] INFO  WEBrick 1.3.1
[2013-08-29 13:27:36] INFO  ruby 2.0.0 (2013-06-27) [i686-linux]
[2013-08-29 13:27:36] INFO  WEBrick::HTTPServer#start: pid=4188 port=9292


$ heroku create factorizor
$ git push heroku master

Continuous Integration with Travis
---------------------------------------

travis init ruby --rvm 2.0.0


 

