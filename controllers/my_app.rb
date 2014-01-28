require 'sinatra/base'

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
    puts params[:username], params[:password]
    erb :my_try
  end
end
