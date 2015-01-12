module Homer
  
  class Service

    def self.api_fqdn
      raise NotImplementedError, "Service subclass must extend #api_fqdn"
    end

    def self.on(location, settings={})
      raise NotImplementedError, "Service subclass must extend #on"
    end

    def self.off(location, settings={})
      raise NotImplementedError, "Service subclass must extend #off"
    end

    def self.set(location, settings={})
      raise NotImplementedError, "Service subclasses must extend #set"
    end

  end

end
