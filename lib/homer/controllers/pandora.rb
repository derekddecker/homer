module Homer

  class Pandora < Controller

    BIN_PATH = File.join(File.dirname(__FILE__), '..', '..', '..', 'bin')

    def self.open(location, settings)
      puts "Launching pandora..."
      spawn("#{BIN_PATH}/pandora.sh")
    end
    self.singleton_class.send(:alias_method, :launch, :open)
    self.singleton_class.send(:alias_method, :play, :open)
    self.singleton_class.send(:alias_method, :on, :open)
  end

end
