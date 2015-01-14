module Homer
  
  class Controller

    def self.api_fqdn
      raise NotImplementedError, "Service subclass must extend #api_fqdn"
    end

  end

end
