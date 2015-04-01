# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/file_watcher/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-file-watcher"
  spec.version       = Rack::FileWatcher::VERSION
  spec.authors       = ["daichi.hirata"]
  spec.email         = ["hirata.daichi@gmail.com"]

  spec.summary       = "Rack middleware to handle events on file modifications"
  spec.description   = "Rack middleware to handle events on file modifications"
  spec.homepage      = "https://github.com/daic-h/rack-file-watcher"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
end
