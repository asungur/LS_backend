require "sinatra"
require "sinatra/reloader"
require "yaml"

before do
  @users = YAML.load_file('./users/yaml')
end

helpers do
  def count_interests
    total = 0
    @users.each do |user, info|
      total += info[:interests].size
    end
  end
end

get "/" do
  redirect 'list'
end

get '/list' do
  @title = "Users list"
  
  erb :list
end

get "/:user" do
  @user_name = params[:user].to_sym
  @email = @users[@user_name][:email]
  @interests = @users[@user_name][:interests]
  @title = "User: #{@user_name.capitalize}"
  
  erb :user
end