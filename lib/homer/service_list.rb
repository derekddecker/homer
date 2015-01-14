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
      service[:controller]
    end

  end

end
