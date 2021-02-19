
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "axi_tdl/version"

Gem::Specification.new do |spec|
  spec.name          = "axi_tdl"
  spec.version       = AxiTdl::VERSION
  spec.authors       = ["Cook.Darwin"]
  spec.email         = ["cook_darwin@hotmail.com"]

  spec.summary       = %q{Axi is a light weight axi library. Tdl is a hardware Construction language}
  spec.description   = %q{tdl is a hardware Construction language, it like chisel, but more intresting. It is a DSL and base on ruby. Finally, it convert to systemverilog. }
  spec.homepage      = "https://www.github.com/CookDarwin/axi_tdl"
  spec.license       = "LGPL-2.1"
  spec.files         = Dir['lib/**/*']
  spec.require_paths = ["lib"]

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.files         = (spec.files + Dir['lib/axi/**','lib/tdl/**', 'lib/axi/**/*','lib/tdl/**/*']).union
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "minitest"
end
