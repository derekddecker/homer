module Homer
  
  class Hue < Service

    def self.api_fqdn
      "http://hue_fqdn"
    end 

    def self.on(location, settings={})
      get("#{api_fqdn}/turn_on_lights", settings)
    end

  end

end
