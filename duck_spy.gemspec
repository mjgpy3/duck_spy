Gem::Specification.new do |s|
  s.name = 'duck_spy'
  s.version = '0.0.1'
  s.licenses = ['MIT']
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ['Michael "Gilli" Gilliland']
  s.homepage = 'https://github.com/mjgpy3/duck_spy'
  s.date = '2014-12-03'
  s.summary = 'Interface spy for Ruby!'
  s.description = 'Your wildest dreams have come true! Interface spy in Ruby!'
  s.files = ['README.md',
             './lib/duck_spy.rb',
             './spec/lib/duck_spy_spec.rb']
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rake'
end
