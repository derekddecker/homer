require 'homer'
require 'homer/service/hue'
require 'sinatra'

Homer.config do |homer|
  homer.define :labels => "lights", :locations => ["kitchen", "bedroom"], :class => Homer::Hue
end

class HomerSample < Sinatra::Base

  before do
    response.headers['Access-Control-Allow-Origin'] = 'http://localhost:9293'
  end

  get "*" do
    Homer.delegate(params['SPOKEN_COMMAND'])    
  end

end 
