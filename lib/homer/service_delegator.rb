module Homer

  class ServiceDelegator

    def self.delegate(command)
      compound_service_response = CompoundServiceResponse.from_command(command)
      command.labels.each do |label|
        command.locations.each do |location|
          begin
            response = ServiceResponse.new
            response["service_class"] = Homer.services.service_for_label_and_location(label, location)
            response["api_response_body"] = response["service_class"].send(command.action.first, command.locations, command.settings)
          rescue => e
            response = ErrorResponse.from_exception(e)
          end
          compound_service_response["responses"] << response
        end
      end
      compound_service_response
    end

  end

end
