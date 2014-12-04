duck_spy
========

[![Build Status](https://travis-ci.org/mjgpy3/duck_spy.svg)](https://travis-ci.org/mjgpy3/duck_spy)

A spy that can be passed to ruby code, and describe what kind of interfaces it expects.

# Examples

## Spy behavior
a `DuckSpy` tells you what methods (and what arguments) have been called.
```
spy = DuckSpy.new

spy.foo(42)

puts spy.calls
```
Outputs:
```
{:foo=>{:args=>[42], :result_duck=>{}}}

```
