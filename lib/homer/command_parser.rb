require 'ostruct'

module Homer

  class CommandParser

    class Command < OpenStruct ; end

    def self.parse(command_string)
      command = Command.new
      pre_in, post_in = *command_string.downcase.split(" in ")
      pre_in_words = pre_in.split(" ")
      command.service = pre_in_words.shift
      command.action = pre_in_words.shift
      command.settings = pre_in_words.join(" ") # whatever remains before "in"
      command.location = post_in
      command
    end

  end

end
