resource "assets" do
  get url: ":file", controller: "AssetsController", method: "deal"
end

get url: "/", controller: "BashController", method: "root"
resource "bash" do
  get url: "/data", controller: "BashController", method: "data"
  get url: "/", controller: "BashController", method: "root"
end
resource "zsh" do
  get url: "/data", controller: "ZshController", method: "data"
  get url: "/", controller: "ZshController", method: "root"
end
