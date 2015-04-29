module Homer
  
  class Nest < Controller

    ENDPOINTS = {
      "set_temperature" => '/temperature'
    }

    def self.api_fqdn
      "http://nest_fqdn"
    end 

    def set
      #get("#{api_fqdn}/turn_on_lights", settings)
      "#{ENDPOINTS['set_temperature']} [Locations: #{command.location.join(" and ")}] [Settings: #{command.settings}]"
    end

  end

end
