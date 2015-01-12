require 'ostruct'

module Homer

  class CommandParser

    class Command < OpenStruct ; end

    # Conventions:
    # [Service] [Action] (the)? [Settings] in (the)? [Locations]
    # (Turn)? [Action] (the)? [Service] (to [Settings])? in (the)? [Location]
    # [Location] [Service] [Action] [Settings]

    def self.parse(command_string)
      command = Command.new
      pre_in, post_in = *command_string.downcase.split(" in ")
      pre_in_words = pre_in.split(" ")
      command.phrase = command_string
      command.label = pre_in_words.shift
      command.action = pre_in_words.shift
      command.settings = pre_in_words.join(" ") # whatever remains before "in"
      command.location = post_in.gsub(/the/,"").chomp
      command
    end

  end

end
