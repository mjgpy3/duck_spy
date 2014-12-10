class DuckSpy
  def initialize
    @calls = {}
    @behaviors = {}
  end

  def behave_like(behaviors)
    behaviors.each do |method, value|
      @behaviors.merge!(method => ->{ value })
    end
  end

  def stub(method, &block)
    @behaviors.merge!(method => block)
  end

  def calls
    @calls.reduce({}) do |hsh, (method, details)|
      hsh.merge(
        method => details.merge(result_duck: details[:result_duck].calls)
      )
    end
  end

  def method_missing(name, *args)
    new_duck = DuckSpy.new.tap do |new_duck|
      @calls[name] = { args: [*args], result_duck: new_duck }
    end

    @behaviors.key?(name) ? @behaviors[name].(*args) : new_duck
  end
end
