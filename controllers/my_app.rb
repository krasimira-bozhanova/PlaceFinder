require 'sinatra/base'
require_relative '../models/user'

class MyApp < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')
  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  get '/' do
    erb :home
  end

  get '/top' do
    erb :top
  end

  get '/search' do
    erb :search
  end

  post "/gag" do
    puts "In post"
    if User.login params[:username], params[:password]
      puts "Login!!"
      @name = User.name_from_username params[:username]
      puts @name
      erb :signed_in
    else
      erb :home
    end
  end
end
