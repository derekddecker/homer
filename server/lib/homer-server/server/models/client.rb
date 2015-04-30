require 'active_record'

module Homer
  module Server
    class Client < ActiveRecord::Base

      has_many :services, :class => 'Homer::Server::Service'
      after_initialize :generate_api_key
      validates_presence_of :fqdn, :port, :api_key

      def generate_api_key
        self.api_key = SecureRandom.base64(20)
      end

      def to_json
        {
          :fqdn => self.fqdn,
          :port => self.port,
          :api_key => self.api_key
        }.to_json
      end

    end
  end
end