module Homer

  class ServiceList < Array

    def locations
      collect_uniq_for_key(:locations)
    end

    def labels
      collect_uniq_for_key(:labels)
    end      

    def collect_uniq_for_key(key)
      self.inject([]) do |result, hash|
        result << hash[key]
      end.flatten.uniq
    end

    def service_for_label_and_location(label, location)
      label = (label || "").downcase.strip
      location = (location || "").downcase.strip
      service = self.find { |service| service[:labels].include?(label) && (service[:locations].include?(location) || location.empty?) }
      raise Homer::UnknownServiceLabelException, label if service.nil?
      service[:class]
    end

  end

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
      @services ||= ServiceList.new
    end

    def define(opts)
      services <<  OptsParser.parse(opts)
    end

  end

end
