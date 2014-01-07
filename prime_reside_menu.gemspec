require File.expand_path('../lib/prime_reside_menu/version.rb', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "prime_reside_menu"
  spec.version       = PrimeResideMenu::VERSION
  spec.authors       = ["Iskander Haziev"]
  spec.email         = ["gvalmon@gmail.com"]
  spec.description   = %q{RESideMenu integration for MotionPrime.}
  spec.summary       = %q{RESideMenu integration for MotionPrime.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + ["README.md"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "cocoapods"
  spec.add_dependency "motion-cocoapods"
  spec.add_dependency "motion-require"
end
