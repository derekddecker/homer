require 'homer'
require 'homer/service/hue'
require 'sinatra'

Homer.config do |homer|
  homer.define "lights", Homer::Hue
end

class HomerSample < Sinatra::Base

  get "*" do
    begin
      Homer.delegate(params['SPOKEN_COMMAND'])    
    rescue => e
      # route to default service (Droid, Google, Amazon Echo, Siri, whatever)
      puts e.inspect
      puts e.backtrace
    end
  end

end 
