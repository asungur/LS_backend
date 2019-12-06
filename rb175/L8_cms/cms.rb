require "sinatra"
require "sinatra/reloader"

root = File.expand_path("..",__FILE__)

get "/" do
  @files = Dir["./data/*"].map { |path| File.basename(path) }
  erb :index
end

get "/:filename" do
  file_path = root + "/data/" + params[:filename]
  
  headers["Content-Type"] = "text/plain"
  File.read(file_path)
end