module Homer

  class InvalidServiceException < StandardError ; end
  class UnknownServiceLabelException < StandardError ; end

  class MissingSetting < StandardError
    def initialize(msg=nil)
      msg ||= ":labels, :locations, :class are required settings"
      super
    end
  end

end
