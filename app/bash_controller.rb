require_relative 'shell_controller'

class BashController < ShellController

  H_FILE = File.expand_path(".bash_history", ENV["HOME"])
  def get_history_list
    File.read(H_FILE).force_utf8.split("\n").select{|e| e.match(/\A\w/)}
  end
end
