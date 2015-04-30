require 'homer-client'

server = Homer::Client::ServerDiscovery.discover!
puts server.inspect