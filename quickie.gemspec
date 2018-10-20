$LOAD_PATH.unshift 'lib'
require "quickie/version"
Gem::Specification.new do |s|
  s.name              = "quickie"
  s.version           = Quickie::VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "Feed me."
  s.homepage          = "http://github.com//quickie"
  s.email             = "vas.kaloidis@gmail.com"
  s.authors           = [ "vaskaloidis" ]
  s.has_rdoc          = false
  s.files             = %w( README.md Rakefile LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.files            += Dir.glob("man/**/*")
  s.files            += Dir.glob("test/**/*")
#  s.executables       = %w( quickie )
  s.description       = <<desc
  Feed me.
desc
end
