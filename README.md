duck_spy
========

[![Build Status](https://travis-ci.org/mjgpy3/duck_spy.svg)](https://travis-ci.org/mjgpy3/duck_spy)

A spy that can be passed to ruby code, and describe what kind of interfaces it expects.

# Motivation

In languages that use a fair amount of duck-typing (e.g. Ruby), it's nice to know exactly what duck a method expects (i.e. it's implicit interface).

The hope is that the "duck spy" will touch certain paths of code to, at least, make these interfaces somewhat more evident.

# Examples

## Spy behavior
A `DuckSpy` tells you what methods (and what arguments) have been called.
```ruby
spy = DuckSpy.new

spy.foo(42)

spy.calls
```
Returns:
```ruby
{
    :foo => {
               :args => [
            42
        ],
        :result_duck => {}
    }
}
```

A `DuckSpy` can also tell you what interface it expects its result to be able to fulfil.
```ruby
spy = DuckSpy.new

spy.foo.baz(:some, 'args')

spy.calls
```
Returns:
```ruby
{
    :foo => {
               :args => [],
        :result_duck => {
            :baz => {
                       :args => [
                    :some,
                    "args"
                ],
                :result_duck => {}
            }
        }
    }
}
```

## Stubbing
A `DuckSpy`'s behavior can be stubbed one of two ways:
```ruby
spy = DuckSpy.new

spy.behave_like(a: 35, b: 7)

spy.a + spy.b  # => 42
```

Or, lazily:
```ruby
spy = DuckSpy.new

spy.stub(:add) { |a, b| a + b }

spy.add(35, 7) # => 42
```
