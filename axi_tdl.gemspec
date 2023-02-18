lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "axi_tdl/version"

Gem::Specification.new do |spec|
  spec.name          = "axi_tdl"
  spec.version       = AxiTdl::VERSION
  spec.authors       = ["Cook.Darwin"]
  spec.email         = ["cook_darwin@hotmail.com"]

  spec.summary       = %q{Axi 是一个轻量级的AXI4库. Tdl 是一种硬件构造语言}
  spec.description   = %q{tdl 是一种硬件构造语言, 和chisel类似, 但是更加有趣, 他是一种基于Ruby的DSL. 最终它会编译输出systemverilog 。 }
  spec.homepage      = "https://www.github.com/CookDarwin/axi_tdl"
  # spec.homepage      = "https://rubygems.org/gems/axi_tdl"
  spec.license       = "LGPL-2.1"
  spec.files         = Dir['lib/**/*']
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.6.0'
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|pkg)/})
  end

  spec.files         = (spec.files + Dir['lib/axi/**','lib/tdl/**', 'lib/axi/**/*','lib/tdl/**/*']).union
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  # spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry","~> 0.11"
  spec.add_development_dependency "minitest","~> 5.10"
end
