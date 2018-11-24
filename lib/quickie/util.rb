require 'date'

module Quickie
  module Util

    def remove_extension(file)
      file.split(File.extname file).first
    end

    def code_editor
      value = `echo $EDITOR`.sub('\n', '').strip!
      if value && !value.nil? && value != ''
        say 'Editor: ' + value
        value
      else
        nil
      end
    end

    def open_editor(file, editor_requested = nil)
      path = File.absolute_path(file)

      if editor_requested.nil?

        if editor.nil?
          vim path 
        else
          `$(which #{editor}) #{path}` 
        end

      elsif editor_requested == 'subl'
        subl path

      elsif editor_requested == 'vim'
        vim path

      end
    end

    def current_time
      date = DateTime.now
      date.strftime "%d/%m/%Y %H:%M"
    end

    def git_email
      cmd = `git config --get user.email`
      return cmd ? '' : gitcmd
    end

    def vim(file)
      `$(which vim) #{file}`
    end

    def subl(file)
      `$(which subl) #{file}`
    end

  end
end
