require 'homer'
require 'homer/controller/hue'
require 'homer/controller/intelli_touch'
require 'homer/controller/nest'
require 'homer/controller/pandora'
require 'sinatra'

Homer.config do |homer|
  homer.define :labels => "lights", :locations => ["kitchen", "bedroom"], :controller => Homer::Hue
  homer.define :labels => "lights", :locations => ["pool", "spa", "hot tub"], :controller => Homer::IntelliTouch
  homer.define :labels => "temperature", :locations => ["pool", "spa", "hot tub"], :controller => Homer::IntelliTouch
  homer.define :labels => "temperature", :locations => ["house"], :controller => Homer::Nest
  homer.define :labels => ["pandora","music"], :locations => ["laptop"], :controller => Homer::Pandora
end

class HomerSample < Sinatra::Base

  before do
    response.headers['Access-Control-Allow-Origin'] = 'http://localhost:9293'
  end

  get "*" do
    Homer.delegate(params['SPOKEN_COMMAND'])    
  end

end 
