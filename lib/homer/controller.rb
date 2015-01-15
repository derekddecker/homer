module Homer
  
  class Controller

    attr_accessor :command

    def initialize(command)
      self.command = command
    end

    def self.actions
      self.instance_methods - Homer::Controller.instance_methods
    end

    def self.api_fqdn
      raise NotImplementedError, "Service subclass must extend #api_fqdn"
    end

  end

end
