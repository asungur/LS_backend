require "sinatra"
require "sinatra/reloader"

get "/" do
  Dir["./data/*"]
end