# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shared_ruby_config/version'

Gem::Specification.new do |spec|
  spec.name        = 'shared_ruby_config'
  spec.version     = SharedRubyConfig::VERSION
  spec.authors     = ['Philipp Hansch']
  spec.email       = ['philipp.hansch@esanum.de']

  spec.summary     = 'Danger.systems conventions and rubocop.yml for Ruby projects.'
  spec.description = 'Packages a Dangerfile to be used with Danger for Esanum Ruby projects.'
  spec.homepage    = 'https://github.com/esanum/shared_ruby_config'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_runtime_dependency 'danger'
  spec.add_runtime_dependency 'danger-rubocop'
end
