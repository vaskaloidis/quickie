# frozen_string_literal: true

require "thor"

class Quickie < Thor
  include Thor::Actions

  def self.source_root
    File.dirname(__FILE__)
  end

    desc "bash NAME", "Generate a quick BASH app-skeleton"
  def bash(name)
    copy_file('lib/quickie/templates/bash-quick.sh.tt', "#{name}.sh") # TODO: Rename bash-quick
  end

  desc "bash_lg NAME", "Generate a BASH app-skeleton"
  def bash_lg(name)
    empty_directory("#{name}")
    copy_file('lib/quickie/templates/bash.sh.tt', "#{name}/#{name}.sh") #TODO: Rename bash to bash_lg
  end

  desc "ruby NAME", "Generate a Ruby app-skeleton"
  def ruby(name)
    directory('lib/quickie/templates/ruby', "#{name}")
  end

  desc "gem NAME", "Generate a gem bundle"
  def gem(name)
    `bundle gem --test=rspec --bin #{name}`
  end

  desc "sinatra NAME", "Generate a regular Sinatra app-skeleton"
  def sinatra(name)
    directory('lib/quickie/templates/sinatra', "#{name}")
  end

end
