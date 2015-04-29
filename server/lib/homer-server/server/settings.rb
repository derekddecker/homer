require 'psych'

module Homer
  module Server
    class Settings

      attr_accessor :host, :port, :password, :db_adapter, :db_name

      # @param [Hash] options
      # {
      #   :port_range [String]: the port range for game servers to run on
      #   :master_server_ip [String]: the master server's ip address
      #   :master_server_port [Integer]: the master server's port
      #   :facilitator_port [Integer]: the facilitator server's port
      # }
      # @return [Config]
      def initialize(settings)
        settings.each do |prop, val|
          self.send("#{prop}=", val) if self.respond_to? "#{prop}="
        end
      end

      def self.from_config
        config = Psych.load(File.read('homer.yml'))
        self.new(config)
      end

      def port
        @port || 8080
      end

      def host
        @host || '127.0.0.1'
      end

      def password
        @password || 'temp123'
      end

      def db_adapter
        @db_adapter || 'sqlite3'
      end

      def db_name
        @db_name || 'homer-server.db'
      end

    end
  end
end