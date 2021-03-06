require 'json'
require_relative 'force_utf-8'

TO_DATA_MAX_DEPTH = 4
RENDER_MAX_ELEMENTS = 3000

def to_data_out(x, depth=0)
  return [{name: x.first, size: x.size}] if depth == TO_DATA_MAX_DEPTH
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
    data = to_data_out(h.reverse.shift(RENDER_MAX_ELEMENTS).map(&:split))
    h = nil
    data
  end

  # To implement
  def get_render_html
    File.read("app/views/data_view.html").gsub("/bash/data", "/" + self.class.to_s.gsub("Controller", "").downcase + "/data")
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
    return {html: get_render_html}
  end

end
