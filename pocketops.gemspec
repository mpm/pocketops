# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pocketops/version'

Gem::Specification.new do |spec|
  spec.name          = "pocketops"
  spec.version       = Pocketops::VERSION
  spec.authors       = ["Malte Münchert"]
  spec.email         = ["malte.muenchert@gmx.net"]

  spec.summary       = %q{A highly opinionated provisioning and deployment tool powered by Ansible}
  spec.description   = %q{PocketOps configures your vanilla Ubuntu box as a rails server and offers easy deployments via rake.}
  spec.homepage      = "http://github/mpm/pocketops/"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor"
  spec.add_runtime_dependency "unix-crypt"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
