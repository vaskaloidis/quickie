require "thor"
require 'tmpdir'

module Quickie
  class Main < Thor
    include Thor::Actions
    include Quickie::Util

    SUPPORTED_LANGUAGES = %w[BASH, Ruby].freeze
    ADD_GEMS = false


    def self.source_root
      File.dirname(__FILE__)
    end

    desc "editor", "Prints the editor in use"

    def editor
      code_editor
    end

    desc "set_editor PROGRAM", "Sets the editor in use"

    def set_editor(program)
      `export EDITOR='#{program}'`
    end

    desc "bash NAME", "Generate a quick BASH app-skeleton"

    def bash(name)
      name += ".sh" unless name.end_with? '.sh'
      @name = name
      @date = current_time
      @user = `whoami`
      # @email = gitemail

      copy_file('./templates/bash-quick.sh.tt', "#{name}")

      open_editor name
    end

    desc "ruby NAME", "Generate a Ruby app-skeleton"

    def ruby(name)
      directory('./templates/ruby', "#{name}")
      open_editor name
    end

    desc "gem NAME", "Generate a gem bundle"

    def gem(name)
      `bundle gem --test=rspec --bin #{name}`

      if ADD_GEMS
        inside name do
          insert_into_file "#{name}.gemspec", :after => "Rails::Initializer.run do |config|\n" do
            gems = ask "Which gems would you like to add?"
            gems.split(" ").map {|gem| "  config.gem :#{gem}"}.join("\n")
          end
        end
      end

      open_editor name
    end

    desc "sinatra NAME", "Generate a regular Sinatra app-skeleton"

    def sinatra(name)
      directory('./templates/sinatra', "#{name}")
      open_editor name
    end

    desc "command NAME", "Generate new quickie Command"

    def command(name)
      directory('./templates/quickie_command', "#{name}")
      open_editor '~/Code/Ruby/quickie/'
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

    def listen
      say 'Quickie is listening', GREEN
      historian = Historian.new
      while historian.running?

        q = ask 'CMD> '
        historian.command q

        say historian.output
      end
    end

    desc "clipscript SCRIPT_LANGUAGE NAME", "Create a Script from the Clipboard Contents (OSX Only)"

    def clipscript(language, name)
      case language.downcase
      when 'bash' then
        bash name
      when 'ruby' then
        ruby name
      else
        say "#{language} is not a supported language. Supported Languages: #{SUPPORTED_LANGUAGES.join(', ')}."
      end
    end
  end
end