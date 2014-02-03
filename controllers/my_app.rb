require 'sinatra/base'
require 'rubygems'
require_relative '../models/placefinder'

class MyApp < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')
  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  get '/' do
    if User.login("krasi", "krasi")
      puts "Login!!"
    else
      puts "no login"
    end

    address_id = Address.get_address_id(:residential_complex_id => 2,
                                        :street => "Джеймс Баучер",
                                        :street_number => 76)
    place = Place.get_place(:name => "Табиет",
                            :address_id => address_id,
                            :type_id => 1)
    puts place['date']
    picture = Picture.get_pictures_for_place(place['id']).first
    @name = place['name']
    @description = place['description']
    @picture_path = picture['picture_path']

    puts "Current user:"
    puts User.get_current_user

    if User.is_there_current_user
      puts "In if"
      @username = User.get_current_user_name
      erb :signed_in
    else
      erb :home
    end
  end

  get '/home' do
    erb :home
  end

  get '/register' do
    erb :register
  end

  get '/top' do
    erb :top
  end

  get '/search' do
    @type_options = Type.all
    @residential_complex_options = ResidentialComplex.all
    erb :search
  end

  post "/search" do
    type, zhk = [params[:type], params[:zhk]].map(&:to_i)
    puts type, zhk
    @result_places = Place.filter(type, zhk)
    puts @result_places.inspect
    erb :filtered
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
