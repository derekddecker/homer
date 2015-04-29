require "net/http"
require "uri"

module Homer

  class PandoraNew < Controller

    def change
      uri = URI.parse("http://192.168.1.67:9296")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new("/pianobar/changest")
      request.set_form_data("station" => command.settings.gsub(/to/, ''))
      response = http.request(request)
      response.body
    end

  end

end
