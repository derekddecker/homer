CONFIG = Homer::Client::Settings.from_config

module Homer
  module Client
    class Server

      SIGNATURE_HEADER  = 'X-Signature'
      attr_accessor :http

      def initialize(ip, port)
        @ip = ip
        @port = port
        @http = Net::HTTP.new(ip, port)
      end

      def ping
        uri = URI.parse("http://#{@ip}:#{@port}/ping")
        request = Net::HTTP::Get.new(uri)
        begin
          sign_request(request)
        rescue => e
          puts e.message
        end
        @http.start{|http| http.request(request)}
      end

      def sign_request(request)
        key = File.read(CONFIG.public_key)
        digest = OpenSSL::Digest.new('sha1')
        data = [request.path, request.body, request['HTTP_COOKIE']] * ''
        hmac = OpenSSL::HMAC.hexdigest(digest, key, data)
        request[SIGNATURE_HEADER] = hmac
      end

    end
  end
end