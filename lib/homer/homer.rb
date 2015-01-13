module Homer

  def self.config(&block)
    yield settings if block_given?
  end

  def self.settings
    @settings ||= Homer::Settings.new
  end

  def self.delegate(phrase)
    command = CommandParser.new(:phrase => phrase, :services => self.settings.services)
    response = ServiceDelegator.delegate(command)
    [ 200, {"Content-Type" => "application/json"}, response.to_json ]
  rescue => e
    error_response = ErrorResponse.new(:phrase => phrase, :message => e.message, :class => e.class)
    puts e.message
    puts e.backtrace
    [ 500, {"Content-Type" => "application/json"}, error_response.to_json ]
  end

end
