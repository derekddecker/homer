require 'ostruct'
require 'json'

module Homer

  class ServiceResponse < OpenStruct
  
    def to_json
      self.marshal_dump.inject({}){ |m,(k,v)| m[k.to_s] = v ; m }.to_json
    end

  end

end
