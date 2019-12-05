require "sinatra"
require "sinatra/reloader"

get "/" do
  @files = Dir["./data/*"].map { |path| File.basename(path) }
  erb :index
end