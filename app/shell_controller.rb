require 'json'

MAX_DEPTH = 4

def to_data_out(x, depth=0)
  return [{name: x.first, size: x.size}] if depth == MAX_DEPTH
  x = x.group_by{|tab| tab[0]}
  x.map do |name, content|
    # puts "Grouped with #{name}: "
    # puts "#{content}"
    content = content[1..-1].map{|e| e[1..-1]}
    empty = content.select{|e| e.empty?}
    nempty = content.select{|e| not e.empty?}
    if content.find{|e| e.size > 0}
      children = to_data_out(nempty, depth+1)
      children += [{name: "", size: empty.size}] unless empty.empty?
      {name: name, children: children}
    else
      {name: name, size: content.size + 1}
    end
  end
end

class ShellController < Nephos::Controller

  protected
  # must return a hash like:
  # {
  #   "word" => {
  #     "param1" => {
  #       "other param" => nil
  #     },
  #     "param2" => nil,
  #   }
  # }
  def get_history
    h = get_history_list()
    data = to_data_out(h.map(&:split))
    h = nil
    data
  end

  public
  def data
    return {
      json: {
        name: "flare",
        children: get_history,
      }
    }
  end

  def root
    return {html: File.read("app/data_view.html")}
  end

end
