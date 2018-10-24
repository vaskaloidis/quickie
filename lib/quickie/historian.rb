require 'tmpdir' # Not needed if you are using rails.
require 'tty-command'

class Historian
  attr_reader :shell_type, :running, :tty, :commands, :outputs, :conditional, :success

  SHELL_TYPES = [:bash, :zsh]

  def initialize(condition = nil)
    @conditional = condition.nil? ? nil : condition
    @running = true
    @tty = TTY::Command.new(pty: true)
    @commands = []
    @outputs = []
    @succsess = nil
  end

  def running?
    running
  end

  def command(cmd)
    if cmd == 'stop'
      running = false
    else
      if conditional.nil
        result = tty.run(cmd) unless !conditional.nil? && (cmd == conditional?)
        outputs << result

        if result.success?
          commands << cmd if conditional.nil? || (!conditional.nil? && cmd == conditional?)
          @success = true
        else
          @success = false
        end
      end
    end
  end


  def output
    outputs.last
  end


  # Other way
  def prepare_history
    Dir.mktmpdir do |dir|
      histfile = `echo $HISTFILE`
      tmp = File.join(dir, history_start.txt)
      FileUtil.copy_file histfile, tmp
      # Diffy::Diff.new(histfile, tmp, :source => 'files')
    end
  end

  def shell_type
    @shell_type ||= begin

      current = cmd('echo $0').downcase
      if current
        return :zsh if current.include?('zsh')
      end

      default = cmd('echo $SHELL').downcase
      if default
        :bash if default.include?('bash') || default.include?('/bin/sh')
      else
        nil
      end
    end
  end


  def setup
    cmd = TTY::Command.new
    cmd.run 'export HISTFILE="$HOME/.zhistory"'
    cmd.run 'export HISTSIZE=10000000'
    cmd.run 'export SAVEHIST=10000000'
    cmd.run 'export setopt INC_APPEND_HISTORY' # Write to the history file immediately, not when the shell exits.
    cmd.run 'export setopt HIST_REDUCE_BLANKS' # Remove superfluous blanks before recording entry.
  end


  private

  def cmd(command)
    `#{command}`
  end

end