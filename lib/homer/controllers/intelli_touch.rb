module Homer
  
  class IntelliTouch < Controller

    ENDPOINTS = {
      "on" => '/turn_on_lights',
      "off" => '/turn_off_lights',
      "set" => '/set_temperature'
    }

    def self.api_fqdn
      "http://intellitouch_fqdn"
    end 

    def on
      "#{ENDPOINTS['on']} [Locations: #{command.locations.join(" and ")}] [Settings: #{command.settings}]"
    end

    def set
      "#{ENDPOINTS['set']} [Locations: #{command.locations.join(" and ")}] [Settings: #{command.settings}]"
    end

  end

end
