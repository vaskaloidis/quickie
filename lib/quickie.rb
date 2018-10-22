# frozen_string_literal: true

require "thor"

class Quickie < Thor
  include Thor::Actions

  def self.source_root
    File.dirname(__FILE__)
  end

  # Generators
  desc "bash NAME", "Generate a quick BASH app-skeleton"
  def bash(name)
    copy_file('./quickie/templates/bash-quick.sh.tt', "#{name}.sh") # TODO: Rename bash-quick
    `subl #{name}.sh`
  end

  desc "bash_lg NAME", "Generate a BASH app-skeleton"
  def bash_lg(name)
    empty_directory("#{name}")
    copy_file('./quickie/templates/bash.sh.tt', "#{name}/#{name}.sh") #TODO: Rename bash to bash_lg
    `subl #{name}/`
  end

  desc "ruby NAME", "Generate a Ruby app-skeleton"
  def ruby(name)
    directory('./quickie/templates/ruby', "#{name}")
    `subl #{name}`
  end

  desc "gem NAME", "Generate a gem bundle"
  def gem(name)
    `bundle gem --test=rspec --bin #{name}`
    `subl #{name}`
  end

  desc "sinatra NAME", "Generate a regular Sinatra app-skeleton"
  def sinatra(name)
    directory('./quickie/templates/sinatra', "#{name}")
    `subl #{name}`
  end

  desc "command NAME", "Generate new quickie Command"
  def command(name)
    directory('./quickie/templates/sinatra', "#{name}")
    `subl ~/Code/Ruby/quickie/`
  end

  # CLI Helper Utils
  desc "checkin", "Checkin code quickly, commit message is optional. Master / Origin branch and remote are default unless specified with --branch <branch-name> --remote <remote-name>"
  def checkin # message: nil, branch: 'master', remote: 'origin'
    `git status`
    # Add a simple yes / no here (press enter to continue or space)
    echo `git add -A && git commit -m "Checkin" && git push origin master`
  end


end
