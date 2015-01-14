module Homer
  
  class Nest < Controller

    ENDPOINTS = {
      "set_temperature" => '/temperature'
    }

    def self.api_fqdn
      "http://nest_fqdn"
    end 

    def self.set(location, settings={})
      #get("#{api_fqdn}/turn_on_lights", settings)
      "#{ENDPOINTS['set_temperature']} [Locations: #{location.join(" and ")}] [Settings: #{settings}]"
    end

  end

end
