require 'sinatra'

class HomerClientSample < Sinatra::Base

  get "/" do
    erb :index
  end

end 
