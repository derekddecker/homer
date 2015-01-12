module Homer

  class Settings
    
    class OptsParser
      
      # :labels [Array<String>]
      # :locations [Array<String>]
      # :class Homer::Service
      def self.parse(opts)
        raise Homer::MissingSetting if((opts.keys <=> [:labels, :locations, :class]) == 1)
        labels = Array(opts[:labels]).map(&:downcase).flatten
        locations = Array(opts[:locations]).map(&:downcase).flatten
        service_class = opts[:class]
        raise Homer::InvalidServiceException if !service_class.class == Class || !service_class.ancestors.include?(Homer::Service)
        { :class => service_class, :labels => labels, :locations => locations }
      end

    end

    def services
      @services ||= []
    end

    def define(opts)
      services <<  OptsParser.parse(opts)
    end

  end

  def self.config(&block)
    yield settings if block_given?
  end

  def self.settings
    @settings ||= Settings.new
  end

  def self.delegate(phrase)
    command = CommandParser.parse(phrase)
    response = ServiceDelegator.delegate(command)
    [ 200, {"Content-Type" => "application/json"}, response.to_json ]
  rescue => e
    error_response = ErrorResponse.new(:phrase => phrase, :message => e.message, :class => e.class)
    [ 500, {"Content-Type" => "application/json"}, error_response.to_json ]
  end

end
