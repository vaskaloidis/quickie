require 'date'

module Quickie
  module Util

    def code_editor
      value = `echo $EDITOR`.sub('\n', '').strip!
      if value && !value.nil? && value != ''
        say 'Editor: ' + value
        value
      else
        nil
      end
    end

    def open_editor(file)
      path = File.absolute_path(file)
      `$(which #{editor}) #{path}` unless editor.nil?
    end

    def current_time
      date = DateTime.now
      date.strftime "%d/%m/%Y %H:%M"
    end

    def git_email
      cmd = `git config --get user.email`
      return cmd ? '' : gitcmd
    end

  end
end