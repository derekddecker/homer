module Homer
  
  class IntelliTouch < Service

    ENDPOINTS = {
      "on" => '/turn_on_lights',
      "off" => '/turn_off_lights',
      "set" => '/set_temperature'
    }

    def self.api_fqdn
      "http://intellitouch_fqdn"
    end 

    def self.on(location, settings={})
      "#{ENDPOINTS['on']} [Locations: #{location.join(" and ")}] [Settings: #{settings}]"
    end

    def self.set(location, settings={})
      "#{ENDPOINTS['set']} [Locations: #{location.join(" and ")}] [Settings: #{settings}]"
    end

  end

end
