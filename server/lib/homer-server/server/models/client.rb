require 'active_record'

module Homer
  module Server
    class Client < ActiveRecord::Base

      attr_accessor :id, :fqdn, :port, :actions, :label

    end
  end
end