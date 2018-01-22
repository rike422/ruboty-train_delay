# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/train_delay/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-train_delay"
  spec.version       = Ruboty::TrainDelay::VERSION
  spec.authors       = ["akira.takahashi"]
  spec.email         = ["rike422@gmail.com"]
  spec.summary       = %q{check train status}
  spec.description   = %q{check train status}
  spec.homepage      = "https://github.com/rike422/ruboty-train_delay"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "ruboty"
  spec.add_runtime_dependency "nokogiri", '~> 1.8.1'
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
