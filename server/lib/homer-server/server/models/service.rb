require 'active_record'

module Homer
  module Server
    class Service < ActiveRecord::Base

      belongs_to :client, :class => 'Homer::Server::Client'

      def to_json
        {
          :labels => self.labels,
          :locations => self.locations,
          :actions => self.actions
        }.to_json
      end

    end
  end
end