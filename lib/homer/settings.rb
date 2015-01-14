module Homer

  class Settings

    class OptsParser
      
      # :labels [Array<String>]
      # :locations [Array<String>]
      # :controller Homer::Controller
      def self.parse(opts)
        raise Homer::MissingSetting if((opts.keys <=> [:labels, :locations, :controller]) == 1)
        labels = Array(opts[:labels]).map(&:downcase).flatten
        locations = Array(opts[:locations]).map(&:downcase).flatten
        service_controller = opts[:controller]
        raise Homer::InvalidServiceException if !service_controller.class == Class || !service_controller.ancestors.include?(Homer::Controller)
        { :controller => service_controller, :labels => labels, :locations => locations }
      end

    end

    def services
      @services ||= ServiceList.new
    end

    def define(opts)
      services <<  OptsParser.parse(opts)
    end

  end

end
