module Homer
  class Pandora < Service

    BIN_PATH = File.join(File.dirname(__FILE__), '..', '..', '..', 'bin')

    def self.open(location, settings)
      puts "Launching pandora..."
      spawn("#{BIN_PATH}/pandora.sh")
    end
    self.singleton_class.send(:alias_method, :launch, :open)
    self.singleton_class.send(:alias_method, :player, :open)
    self.singleton_class.send(:alias_method, :on, :open)
  end
end
