module Homer

  module Server

    def self.config(&block)
      yield settings if block_given?
    end

    def self.services
      @settings.services || []
    end

    def self.settings
      @settings ||= Homer::Settings.new
    end

    def self.delegate(phrase)
      CommandParser.new(:phrase => phrase, :services => self.settings.services)
    end

  end

end
