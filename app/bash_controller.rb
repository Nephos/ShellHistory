require_relative 'shell_controller'

class BashController < ShellController
  def get_history_list
    File.read("/home/poulet_a/.bash_history").split("\n").select{|e| e.match(/\A\w/)}
  end
end
