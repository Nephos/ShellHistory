require_relative 'shell_controller'

class FishController < ShellController

    H_FILE = File.expand_path(".config/fish/fish_history", ENV["HOME"])
    def get_history_list
      File.read(H_FILE).force_utf8.split("\n").select{|l| l.match(/\A- cmd: /)}.map{|e| e.gsub(/\A- cmd: /, '')}
    end

end
