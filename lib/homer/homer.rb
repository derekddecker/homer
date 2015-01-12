module Homer

  class Settings
    
    def services
      @services ||= {}
    end

    def define(service_label, service_class)
      raise Homer::InvalidServiceException if !service_class.class == Class || !service_class.ancestors.include?(Homer::Service)
      services[service_label.downcase] = service_class
    end

  end

  def self.config(&block)
    yield settings if block_given?
  end

  def self.settings
    @settings ||= Settings.new
  end

end
