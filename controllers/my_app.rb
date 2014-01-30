require 'sinatra/base'
require 'rubygems'
require_relative '../models/user'
require_relative '../models/picture'
require_relative '../models/address'
require_relative '../models/type'
require_relative '../models/place'

class MyApp < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')
  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  get '/' do
    address_id = Address.get_address_id(:zhk => "Лозенец", :street => "Джеймс Баучер", :street_number => 76)
    place = Place.get_place(:name => "Табиет",
                            :address_id => address_id,
                            :type_id => 1)
    picture = Picture.get_pictures_for_place(:place_id => place.id).first
    @name = place.name
    @description = place.description
    @picture_path = "img/" + picture['picture_path']
    if User.has_current_user
      @name = User.get_current_user_name
      erb :signed_in
    else
      erb :home
    end
  end

  get '/top' do
    erb :top
  end

  get '/search' do
    erb :search
  end

  post "/login" do
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

  get "/upload" do
    erb :upload
  end

  post "/upload" do
    puts params[:file].inspect
    File.open("uploads/" + params[:file][:filename], "w") do |f|
      f.write(params[:file][:tempfile].read)
    end
    "The file was successfully uploaded!"
  end
end
