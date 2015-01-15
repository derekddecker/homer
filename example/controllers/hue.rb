module Homer
  
  class Hue < Controller

    ENDPOINTS = {
      "on" => '/turn_on_lights',
      "off" => '/turn_off_lights'
    }

    def self.api_fqdn
      "http://hue_fqdn"
    end 

    def on
      #get("#{api_fqdn}/turn_on_lights", settings)
      "#{ENDPOINTS['on']} [Locations: #{command.locations.join(" and ")}] [Settings: #{command.settings}]"
    end

  end

end
