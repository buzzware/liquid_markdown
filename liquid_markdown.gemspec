# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liquid_markdown/version'

Gem::Specification.new do |spec|
  spec.name          = 'liquid_markdown'
  spec.version       = LiquidMarkdown::VERSION
  spec.authors       = ['Gary McGhee']
  spec.email         = ['gary@buzzware.com.au']

  spec.summary       = %q{Combines Liquid and Markdown templating for generic templating and Rails Mailers}
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/buzzware/liquid_markdown'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'kramdown'
  spec.add_dependency 'liquid', '~> 4.0.0.rc3'
  spec.add_dependency 'actionmailer'
  spec.add_dependency 'actionview'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry-meta'
end
