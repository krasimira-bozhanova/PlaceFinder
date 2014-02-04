require 'sinatra/base'
require 'rubygems'
require_relative '../models/placefinder'

class MyApp < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')
  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  get '/' do
    number = Place.all.size < 5 ? Place.all.size : 5
    @newest_places = Place.get_newest_places(number)
    erb :home
  end

  get '/logout' do
    User.logout
    redirect '/'
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    begin
      User.register_user params[:username], params[:password], params[:repeat_password], params[:name]
    rescue RegisterException => e
      @message = e.message
      erb :register_failure
    else
      erb :register_successful
    end
  end

  get '/top' do
    number = Place.all.size < 5 ? Place.all.size : 5
    @top_places = Place.get_places_with_highest_ratings(number)
    erb :top
  end

  get '/search' do
    @type_options = Type.all.sort_by(&:name)
    @residential_complex_options = ResidentialComplex.all.sort_by(&:name)
    erb :search
  end

  post "/search" do
    type, zhk = [params[:type], params[:zhk]].map(&:to_i)
    @result_places = Place.filter(type, zhk)
    erb :filtered
  end

  post "/login" do
    if User.login params[:username], params[:password]
      @name = User.name_from_username params[:username]
    end
    redirect '/'
  end

  get "/upload" do
    erb :upload
  end

  post "/upload" do
    File.open("uploads/" + params[:file][:filename], "w") do |f|
      f.write(params[:file][:tempfile].read)
    end
    "The file was successfully uploaded!"
  end
end
