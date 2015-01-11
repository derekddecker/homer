class CommandParser

  def self.parse(command)
    # this is contrived, since I haven't worked with any in the past...
    pre_in, post_in = *command.downcase.split(" in ")
    pre_in_words = pre_in.split(" ")
    service = pre_in_words.shift
    action = pre_in_words.shift
    settings = pre_in_words.join(" ") # whatever remains before "in"
    location = post_in
    [service, action, location, settings]
  end

end
