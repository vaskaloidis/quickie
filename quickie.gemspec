
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


require "quickie/version"

Gem::Specification.new do |spec|
  spec.name              = "quickie"
  spec.version           = Quickie::VERSION
  spec.date              = Time.now.strftime('%Y-%m-%d')
  spec.homepage          = "http://www.bluehelmet.software"
  spec.summary           = "Code, application and script skeleton generator."
  spec.description       = 'Quickie gets projects going by generating the code skeletons for commonly generated projects and often repeated developer tasks + workflows'
  spec.homepage          = "http://github.com//quickie"
  spec.email             = "vaspec.kaloidis@gmail.com"
  spec.authors           = [ "vaskaloidis" ]
  spec.has_rdoc          = false
  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir            = "exe"
  spec.executables       = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files        = spec.files.grep(%r{^(spec)/})
  spec.license           = "MIT"

  spec.require_paths     = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "generator_spec"
  # spec.add_dependency "activesupport"
end
