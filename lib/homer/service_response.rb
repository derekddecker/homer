require 'ostruct'
require 'json'

module Homer

  class Response < OpenStruct

    def to_json
      self.marshal_dump.inject({}){ |m,(k,v)| m[k.to_s] = v ; m }.to_json
    end

  end

  class ServiceResponse < Response
    
    def initialize(h=nil)
      success = true
      super(h)
    end

  end

  class ErrorResponse < Response
    
    def initialize(h=nil)
      success = true
      super(h)
    end

  end

end
