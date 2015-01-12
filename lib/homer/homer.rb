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
    response = ServiceResponse.new(command.marshal_dump)
    response.phrase = phrase
    response.service_class =  service_for_label(command.service)
    response.api_response_body = response.service_class.send(command.action, command.location, command.settings)
    [ 200, {"Content-Type" => "application/json"}, response.to_json ]
  end

end
