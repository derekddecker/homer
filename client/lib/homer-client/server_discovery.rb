require 'ipaddr'
require "net/http"
require "uri"

module Homer
  module Client
    class ServerDiscovery

      HOMER_VERSION_HEADER = 'X-Homer-Version'
      ADDITIONAL_IPS = ['127.0.0.1']
      IP_BLOCK = "192.168.1.0/24"
      HOMER_SERVER_LISTEN_PORT = 8080
      OPEN_TIMEOUT = 2
      READ_TIMEOUT = 1

      def self.discover!
        results = []
        children = Array(IPAddr.new(IP_BLOCK).to_range).concat(ADDITIONAL_IPS).uniq.map do |ipaddr|
          Thread.new do
            ip = ipaddr.to_s
            server = Server.new(ip, HOMER_SERVER_LISTEN_PORT)
            server.http.open_timeout = OPEN_TIMEOUT
            server.http.read_timeout = READ_TIMEOUT
            begin
              ping = server.ping
              Thread.exit if ping.header[HOMER_VERSION_HEADER].nil?
              if ping.body == "pong"
                results << server
              else
                puts "Homer Server found, but did not get expected response body: #{ping.body}"
              end
            rescue
            end
            Thread.exit
          end
        end
        children.collect(&:join)
        results
      end

    end
  end
end