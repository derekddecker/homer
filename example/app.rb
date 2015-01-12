require 'homer'
require 'homer/service/hue'
require 'sinatra'

Homer.config do |homer|
  homer.define "lights", Homer::Hue
end

class HomerSample < Sinatra::Base

  before do
    response.headers['Access-Control-Allow-Origin'] = 'http://localhost:9293'
  end

  get "*" do
    begin
      Homer.delegate(params['SPOKEN_COMMAND'])    
    rescue => e
      # route to default service (Droid, Google, Amazon Echo, Siri, whatever)
      puts e.inspect
      puts e.backtrace
      [500, {}, e.message]
    end
  end

end 
