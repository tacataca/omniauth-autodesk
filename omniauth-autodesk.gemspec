
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "omniauth-autodesk/version"

Gem::Specification.new do |gem|
  gem.name          = "omniauth-autodesk"
  gem.version       = Omniauth::Autodesk::VERSION
  gem.authors       = ["Cristian Guerrero"]
  gem.email         = ["cristian.guerrero@ballistiq.com"]
  gem.description   = %q{OmniAuth Strategy for Autodesk OAuth}
  gem.summary       = %W{OmniAuth Strategy for Autodesk OAuth, see https://github.com/ballistiq/omniauth-autodesk for examples and more information.}
  gem.homepage      = "https://github.com/ballistiq/omniauth-autodesk"
  gem.license       = "MIT"

  gem.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_dependency "omniauth", "~> 1.0"
  gem.add_dependency "omniauth-oauth2", "~> 1.0"
  gem.add_dependency "multi_json", "~>  1.5"
  gem.add_development_dependency "rspec", "~> 3.1"
  gem.add_development_dependency "rake", ">= 12.0"
end
