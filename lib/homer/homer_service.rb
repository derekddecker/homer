class HomerService

  def api_fqdn
    raise NotImplementedError, "Service subclass must extend #api_fqdn"
  end

  def on(location, settings={})
    raise NotImplementedError, "Service subclass must extend #on"
  end

  def off(location, settings={})
    raise NotImplementedError, "Service subclass must extend #off"
  end

  def set(location, settings={})
    raise NotImplementedError, "Service subclasses must extend #set"
  end

end
