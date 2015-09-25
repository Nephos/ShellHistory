require_relative 'shell_controller'

class ZshController < ShellController

  H_FILE = File.expand_path(".zsh_history", ENV["HOME"])
  def get_history_list
    File.read(H_FILE).split("\n").map{|s| s.gsub(/: \d+:\d+;/, '')}.select{|e| e.match(/\A\w/)}
  end
end
