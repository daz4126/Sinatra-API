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

get '/info/:number' do
  content_type :json
  number = params[:number].to_i
  info = {
      :factors => number.factors,
      :odd => number.odd?,
      :even => number.even?,
      :prime => number.prime?
  }
  info.to_json
end
