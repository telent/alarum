# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alarum/version'

Gem::Specification.new do |spec|
  spec.name          = "alarum"
  spec.version       = Alarum::VERSION
  spec.authors       = ["Daniel Barlow"]
  spec.email         = ["dan@telent.net"]
  spec.summary       = %q{Digest RRD files (e.g. from collectd) and alert people when things aren't wrking right}
#  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "errand"
  spec.add_dependency "trollop"
  spec.add_dependency "xmpp4r"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "warbler"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
end
