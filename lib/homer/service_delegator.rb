module Homer

  class ServiceDelegator

    def self.delegate(command)
      response = ServiceResponse.new(command.marshal_dump)
      response.service_class = service_for_label_and_location(command.label, command.location)
      response.api_response_body = response.service_class.send(command.action, command.location, command.settings)
      response
    end

    def self.service_for_label_and_location(label, location)
      label = (label || "").downcase.strip
      location = (location || "").downcase.strip
      service = Homer.settings.services.find { |service| opts[:labels].include?(label) && opts[:locations].include?(location) }
      raise Homer::UnknownServiceLabelException, label if service.nil?
      service[:class]
    end

  end

end
