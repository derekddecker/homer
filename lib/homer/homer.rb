module Homer

  class Settings
    
    class OptsParser
      
      class MissingSetting < StandardError
        def initialize(msg=nil)
          msg ||= ":labels, :locations, :class are required settings"
          super
        end
      end

      # :labels [Array<String>]
      # :locations [Array<String>]
      # :class Homer::Service
      def self.parse(opts)
        raise MissingSetting if((opts.keys <=> [:labels, :locations, :class]) == -1)
        labels = Array(opts[:labels]).map(&:downcase).flatten
        locations = Array(opts[:locations]).map(&:downcase).flatten
        service_class = opts[:class]
        raise Homer::InvalidServiceException if !service_class.class == Class || !service_class.ancestors.include?(Homer::Service)
        [ labels, locations, service_class ]
      end

    end

    def services
      @services ||= {}
    end

    def define(opts)
      labels, locations, service_class = *OptsParser.parse(opts)
      services[service_class] = {
        :labels => labels,
        :locations => locations
      }
    end

  end

  def self.config(&block)
    yield settings if block_given?
  end

  def self.settings
    @settings ||= Settings.new
  end

  def self.service_for_label_and_location(label, location)
    label = (label || "").downcase.chomp
    location = (location || "").downcase.chomp
    service = settings.services.find { |(service, opts)| opts[:labels].include?(label) && opts[:locations].include?(location) }
    raise Homer::UnknownServiceLabelException, label if service.nil?
    service[0]
  end

  def self.delegate(phrase)
    command = CommandParser.parse(phrase)
    response = ServiceResponse.new(command.marshal_dump)
    response.phrase = phrase
    response.service_class =  service_for_label(command.service)
    response.api_response_body = response.service_class.send(command.action, command.location, command.settings)
    [ 200, {"Content-Type" => "application/json"}, response.to_json ]
  rescue => e
    error_response = ErrorResponse.new(:phrase => phrase, :message => e.message, :class => e.class)
    [ 500, {"Content-Type" => "application/json"}, error_response.to_json ]
  end

end
