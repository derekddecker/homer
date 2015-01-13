module Homer

  def self.config(&block)
    yield settings if block_given?
  end

  def self.settings
    @settings ||= Homer::Settings.new
  end

  def self.delegate(phrase)
    command = CommandParser.new(:phrase => phrase, :services => self.settings.services)
    ServiceDelegator.delegate(command).to_rack_response
  end

end
