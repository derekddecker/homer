# read config for:
#  - bind port
#  - admin password
require_relative 'bootstrap'

module Homer
  module Server
    class HttpServer < Angelo::Base
      include Angelo::Tilt::ERB

      get '/admin' do
        "Hello."
      end

      # register a homer-client with homer-server
      post '/register' do
        content_type :json
        instance_uuid = SecureRandom.base64(20)
      end
    end
  end
end

Homer::Server::HttpServer.run!(CONFIG.host, CONFIG.port)