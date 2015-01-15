module Homer

  class Pandora < Controller

    BIN_PATH = File.join(File.dirname(__FILE__), '..', '..', '..', 'bin')

    def open
      puts "Launching pandora..."
      spawn("#{BIN_PATH}/pandora.sh")
    end
    alias_method :launch, :open
    alias_method :play, :open
    alias_method :on, :open
  end

end
