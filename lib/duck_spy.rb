class DuckSpy
  def initialize
    @calls = {}
  end

  def calls
    @calls
  end

  def method_missing(name)
    @calls[name] = []
  end
end
