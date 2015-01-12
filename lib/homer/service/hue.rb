module Homer
  
  class Hue < Service

    ENDPOINTS = {
      "on" => '/turn_on_lights',
      "off" => '/turn_off_lights'
    }

    def self.api_fqdn
      "http://hue_fqdn"
    end 

    def self.on(location, settings={})
      #get("#{api_fqdn}/turn_on_lights", settings)
      ENDPOINTS['on']
    end

  end

end
