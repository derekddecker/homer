module Homer

  class InvalidServiceException < StandardError ; end
  class UnknownServiceLabelException < StandardError ; end
  class CommandParseError < StandardError ; end
  class MissingSetting < StandardError
    def initialize(msg=nil)
      msg ||= ":labels, :locations, :controller are required settings"
      super
    end
  end

end
