require 'sinatra/base'
require 'rubygems'
require_relative 'routes/init'

class PlaceFinder < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')
  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }
  set :static, true

  after do
    ActiveRecord::Base.connection.close
  end

  @place_types = Type.all
  puts @place_types.inspect

  get '/' do
    number = Place.all.size < 5 ? Place.all.size : 5
    @newest_places = Place.newest_places(number)
    erb :home
  end

  get %r{/categories/(\d+)} do
    @type_name = Type.type_plural_name_by_id(params[:captures].first)
    @places = Place.places_with_type(params[:captures].first)
    erb :show_places_with_type
  end

  post '/comment' do
    @place = Place.place_by_id params[:place_id]
    @comment = params[:comment_text]
    if not @comment.empty?
      Comment.add_comment :user_id => User.current_user.id,
                          :place_id => @place['id'],
                          :comment => @comment
    end
    erb :show_place
  end

  get %r{/(\d+)} do
    @place = Place.place_by_id(params[:captures].first)
    erb :show_place
  end

  get '/top' do
    number = Place.all.size < 5 ? Place.all.size : 5
    @top_places = Place.places_with_highest_ratings(number)
    erb :top
  end
end
