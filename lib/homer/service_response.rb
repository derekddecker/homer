require 'ostruct'
require 'json'

module Homer

  class Response < ::Hash

    def to_rack_response
      [@http_status,  {"Content-Type" => "application/json"}, self.merge("success" => @success).to_json]
    end

  end

  class ServiceResponse < Response
  
    def initialize 
      @http_status = 200
      @success = true
      super
    end

  end

  class ErrorResponse < Response
    
    def initialize
      @http_status = 500
      @success = false
    end

    def self.from_exception(exc)
      r = self.new
      r["success"] = false
      r["class"] = exc.class
      r["message"] = exc.message
      r
    end

  end

  class CompoundServiceResponse < Response

    def initialize
      @http_status = 200
      @success = true
    end

    def self.from_command(command)
      r = self.new
      r["phrase"] = command.phrase
      r["responses"] = []
      r
    end

  end

end
