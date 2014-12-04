class DuckSpy
  attr_reader :calls
  def initialize
    @calls = {}
  end

  def method_missing(name)
    @calls[name] = []
  end
end
