class DuckSpy
  def initialize
    @calls = {}
  end

  def calls
    return @calls if @calls.empty?

    @calls.reduce({}) do |hsh, (method, details)|
      hsh.merge(
        method => details.merge(result_duck: details[:result_duck].calls)
      )
    end
  end

  def method_missing(name, *args)
    DuckSpy.new.tap do |new_duck|
      @calls[name] = { args: [*args], result_duck: new_duck }
    end
  end
end
