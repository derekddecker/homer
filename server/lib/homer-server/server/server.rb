require 'openssl'
require_relative 'bootstrap'

module Homer
  module Server
    class HttpServer < Angelo::Base
      include Angelo::Tilt::ERB

      POWERED_BY_HEADER = 'X-Powered-By'
      VERSION_HEADER    = 'X-Homer-Version'
      SIGNATURE_HEADER  = 'X-Signature'
      HEADERS = {
        POWERED_BY_HEADER => "Homer Server",
        VERSION_HEADER => Homer::Server::VERSION
      }

      before do
        validate_signature!(request.headers[SIGNATURE_HEADER])
      end

      after do
        headers HEADERS
      end

      get '/admin' do
        "Hello."
      end

      get '/ping' do
        "pong"
      end

      # register a homer-client with homer-server
      post '/register' do
        content_type :json
        client = Client.find(params[:api_key]) rescue Client.new
        client.update_attributes(params)
        error! client.errors.full_messages.join(", ") unless client.valid?
        client.save
        client.to_json
      end

      def validate_signature!(sig)
        key = File.read(CONFIG.public_key)
        uri = request.path
        body = request.body
        cookies = request.headers['HTTP_COOKIE']
        data = [uri, body, cookies] * ''
        digest = OpenSSL::Digest.new('sha1')
        hmac = OpenSSL::HMAC.hexdigest(digest, key, data)
        #info "uri: #{uri}"
        #info "body: #{body}"
        #info "cookies: #{cookies}"
        #info "Generated HMAC: #{hmac}"
        #info "Sent HMAC: #{sig}"
        error! "Signature did not match!" if sig.nil? || hmac != sig
      rescue => e
        fatal e.message
        error! "Error generating signature!"
      end

      def error!(error)
        content_type :json
        headers HEADERS
        raise Angelo::RequestError, error
      end
    end
  end
end

Homer::Server::HttpServer.run!(CONFIG.host, CONFIG.port)