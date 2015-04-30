require 'webkit_remote'

module Homer

  class Pandora < Controller

    def initialize(command)
      super
      @@client ||= nil
    end

    def get_client
      if @@client.nil? || @@client.closed?
        @@client = WebkitRemote.local :port => 9222
      end
      @@client
    end

    def open
      self.get_client.navigate_to "http://pandora.com"
      "Started pandora"
    rescue => e
      puts e.message
      puts e.backtrace
    end
    alias_method :launch, :open
    alias_method :play, :open
    alias_method :on, :open

    def close
      if !@@client.nil? && !@@client.closed?
        @@client.close
        "Killed Pandora"
      else
        "Pandora not started"
      end
    end
    alias_method :stop, :close
    alias_method :off, :close
  end

end
