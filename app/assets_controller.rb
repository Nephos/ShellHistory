class AssetsController < Nephos::Controller

  FILES = Dir[File.expand_path "app/assets/*"].map{|f| File.basename(f)}
  def deal
    if FILES.include? params[:file]
      return {plain: File.read("app/assets/" + params[:file])}
    end
  end

end
