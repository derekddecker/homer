require 'psych'

module Homer
  module Client
    class Settings

      attr_accessor :server_host, :server_port, :public_key

      # @param [Hash] options
      # {
      #   :port_range [String]: the port range for game servers to run on
      #   :master_server_ip [String]: the master server's ip address
      #   :master_server_port [Integer]: the master server's port
      #   :facilitator_port [Integer]: the facilitator server's port
      # }
      # @return [Config]
      def initialize(settings)
        if settings
          settings.each do |prop, val|
            self.send("#{prop}=", val) if self.respond_to? "#{prop}="
          end
        end
      end

      def self.from_config
        config = Psych.load(File.read('homer.yml'))
        self.new(config)
      end

      def public_key
        @public_key || 'keys/homer.pem'
      end

    end
  end
end