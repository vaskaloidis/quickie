# frozen_string_literal: true

require "thor"
require 'date'
require 'tmpdir' # Not needed if you are using rails.

class Quickie < Thor
  include Thor::Actions

  SUPPORTED_LANGUAGES = %w[BASH, Ruby].freeze

  def self.source_root
    File.dirname(__FILE__)
  end

  # TODO: CLI Templates https://github.com/tongueroo/cli-template

  desc "bash NAME", "Generate a quick BASH app-skeleton"
  def bash(name)
    @name = name
    @date = DateTime.now
    @date.strftime "%d/%m/%Y %H:%M"
    @user = `whoami`
    # gitcmd =  `git config --get user.email`
    # @email = gitcmd ? '' : gitcmd

    copy_file('./quickie/templates/bash-quick.sh.tt', "#{name}.sh")

    `subl #{name}.sh`
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

  # CLI Helper + Utils
  desc "checkin", "Checkin code quickly, commit message is optional. Master / Origin branch and remote are default unless specified with --branch <branch-name> --remote <remote-name>"

  def checkin # message: nil, branch: 'master', remote: 'origin'
    say `git status`
    if ask 'Commit Message: PRESS [ENTER] for Default. NO', GREEN, default: 'Quick Checkin.'
      say 'Commiting files'
      say `git add -A`
      say `git commit -m "Checkin"`
      say `git push origin master`, GREEN
    end
  end

  desc "listen", "Start recording Shell commands to generate a BASH script or Code notes."

  desc "clipscript SCRIPT_LANGUAGE NAME", "Create a Script from the Clipboard Contents (OSX Only)"

  private

  def listen
    say 'Quickie is listening', GREEN
    historian = Historian.new

    while historian.running?

      q = ask 'CMD> '
      historian.command q

      say historian.output
    end

  end

  # param [STRING]
  def clipscript(language, name)

    case language.downcase
    when 'bash'then bash name
    when 'ruby' then ruby name
    else
      say "#{language} is not a supported language. Supported Languages: #{SUPPORTED_LANGUAGES.join(', ')}."
    end

  end


end
