require 'ostruct'

module Homer

  class CommandParser < OpenStruct
    
    ACTIONS = [ "on", "off", "set", "play", "open" ]
    KEYWORDS = ["turn", "in" ]
    TRASH = [ "the", "and" ]

    def initialize(opts={})
      opts[:phrase].downcase!
      super(opts)
      raise ArgumentError, "service_list argument must be of type Homer::Settings" if(!opts[:services].is_a?(Homer::ServiceList))
      parse!
    end

    # Conventions:
    # [Service] [Action] (the)? [Settings] in (the)? [Locations]
    # (Turn)? [Action] (the)? [Service] (to [Settings])? in (the)? [Location]
    # [Location] [Service] [Action] [Settings]
    def parse!
      self.locations = parse_locations
      self.locations.push("") if self.locations.empty?
      self.labels = parse_labels
      self.action = parse_action
      self.settings = boil_off(self.phrase, [KEYWORDS, TRASH, locations_as_flat_arr, self.labels, self.action].flatten)
    rescue => e
      raise Homer::CommandParseError, "Failed to parse the command phrase: '#{self.phrase}'. #{e.message}. #{e.backtrace}"
    end

    def parse_action
      find_substrings(self.phrase, ACTIONS)
    end

    def parse_labels
      find_substrings(self.phrase, self.services.labels)
    end

    def parse_locations
      find_substrings(self.phrase, self.services.locations)
    end

    def locations_as_flat_arr
      self.locations.join(" ").split(" ")
    end

    def find_substrings(string, substr_arr)
      results = []
      substr_arr.each do |val|
        results << val if(string.include?(val))
      end
      results
    end

    def boil_off(string, boil_off_arr)
      boiled = " #{string} "
      boil_off_arr.each do |val|
        boiled.gsub!(val,'') if(/\s#{val}\s/.match(boiled))
      end
      boiled.strip.gsub(/\s+/,' ')
    end

    def cleanup_string(str)
      [str.split(" ") - (KEYWORDS + TRASH)].flatten.map(&:strip).join(" ")
    end

  end

end
