resource "assets" do
  get url: ":file", controller: "AssetsController", method: "deal"
end

get url: "/", controller: "BashController", method: "root"
%w(bash zsh fish).each do |shell|
  resource shell do
    get url: "/data", controller: "#{shell.capitalize}Controller", method: "data"
    get url: "/", controller: "#{shell.capitalize}Controller", method: "root"
  end
end
