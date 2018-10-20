# frozen_string_literal: true

require_relative 'quickie/gemspec_generator'
require_relative 'quickie/util'


require "thor"

class Main < Thor
  include Thor::Actions

  def self.source_root
    File.dirname(__FILE__)
  end

  desc "bash NAME", "Generate a BASH app-skeleton"
  def bash(name)
    empty_directory("#{name}")
    copy_file('../templates/bash.sh.tt', "#{name}/#{name}.sh")
  end

  desc "ruby NAME", "Generate a Ruby app-skeleton"
  def ruby(name)
    directory('../templates/ruby', "#{name}")
  end

  desc "sinatra_lg NAME", "Generate a Large Sinatra app-skeleton"
  def sinatra_lg(name)
    directory('../templates/sinatra-large', "#{name}")
  end

  desc "sinatra NAME", "Generate a Sinatra app-skeleton"
  def sinatra(name)
    directory('../templates/sinatra', "#{name}")
  end

    desc "gemspec", "Generate a Gemspec File"
  def sinatra
    folder_name = `pwd`.split('/').last
    GemspecGenerator.new(folder_name).generate
  end
end
