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

  def self.service_for_label(label)
    key = (label || "").downcase.chomp
    raise Homer::UnknownServiceLabelException, label unless settings.services.has_key?(key)
    settings.services[label]
  end

  def self.delegate(phrase)
    command = CommandParser.parse(phrase)
    puts "Delegating for service label: #{command.service}"
    puts "Service handler class: #{service_for_label(command.service)}"
    puts "Action: #{command.action}"
    puts "Location: #{command.location}"
    puts "Settings: #{command.settings}"
    service_for_label(command.service).send(command.action, command.location, command.settings)
  end

end
