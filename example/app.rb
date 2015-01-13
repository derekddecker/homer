require 'homer'
require 'homer/service/hue'
require 'homer/service/intelli_touch'
require 'homer/service/nest'
require 'sinatra'

Homer.config do |homer|
  homer.define :labels => "lights", :locations => ["kitchen", "bedroom"], :class => Homer::Hue
  homer.define :labels => "lights", :locations => ["pool", "spa", "hot tub"], :class => Homer::IntelliTouch
  homer.define :labels => "temperature", :locations => ["pool", "spa", "hot tub"], :class => Homer::IntelliTouch
  homer.define :labels => "temperature", :locations => ["house"], :class => Homer::Nest
end

class HomerSample < Sinatra::Base

  before do
    response.headers['Access-Control-Allow-Origin'] = 'http://localhost:9293'
  end

  get "*" do
    Homer.delegate(params['SPOKEN_COMMAND'])    
  end

end 
