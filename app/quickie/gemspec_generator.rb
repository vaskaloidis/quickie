#!/usr/bin/env ruby
# Usage: gemspec [-s] GEMNAME
#
# Prints a basic gemspec for GEMNAME based on your git-config info.
# If -s is passed, saves it as a GEMNAME.gemspec in the current
# directory. Otherwise prints to standard output.
#
# Once you check this gemspec into your project, releasing a new gem
# is dead simple:
#
# $ gem build GEMNAME.gemspec
# $ gem push GEMNAME-VERSION.gem
#
# Wants you to have a "lib/GEMNAME/version.rb" file in your project
# which sets the GEMNAME::VERSION constant.

require_relative 'util'

class GemspecGenerator

  def initialize(name)
    fullname = Util.github_name
    email    = Util.github_email
    login    = Util.github_user
    abort "* Pass a gem name." if name.nil?
    @name = name
  end

  def generate
gemspec = <<spec
$LOAD_PATH.unshift 'lib'
require "#{@name}/version"
Gem::Specification.new do |s|
  s.name              = "#{@name}"
  s.version           = #{@name.capitalize}::VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "Feed me."
  s.homepage          = "http://github.com/#{login}/#{@name}"
  s.email             = "#{email}"
  s.authors           = [ "#{fullname}" ]
  s.has_rdoc          = false
  s.files             = %w( README.md Rakefile LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.files            += Dir.glob("man/**/*")
  s.files            += Dir.glob("test/**/*")
#  s.executables       = %w( #{@name} )
  s.description       = <<desc
  Feed me.
desc
end
spec


    if File.exist? file = "#{@name}.gemspec"
      abort "* #{file} exists!"
    else
      File.open(file, 'w') { |f| f.puts gemspec }
    end
  end

end
