module PlaceFinder
  class PlaceFinder < Sinatra::Base
    @place_types = Type.all

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
      @comment = params[:comment_text]
      if not @comment.empty?
        Comment.add_comment :user_id => User.current_user.id,
                            :place_id => params[:place_id].to_i,
                            :comment => @comment
      end
      redirect "/#{params[:place_id]}"
    end

    get %r{/(\d+)} do
      @place = Place.place_by_id(params[:captures].first)
      @place_type = Type.type_name_by_id(@place.type_id)
      @is_favourite = Favourite.already_favourite?(User.current_user.id, @place.id)
      @address = Address.address_by_place_id @place.id
      @residential_complex_name = ResidentialComplex.residential_complex_name_by_id(
        @address.residential_complex_id)
      @pictures_for_place = Picture.pictures_for_place(@place.id)
      @comments = Comment.comments_of_place(@place.id)
      rating = Rating.rating_of_place @place.id
      if rating == nil
        @rating = "За това място все още не е гласувано"
      else
        @rating = rating
      end
      @voted_already = Rating.voted_already?(User.current_user.id, @place.id)
      erb :show_place
    end

    get '/top' do
      number = Place.all.size < 10 ? Place.all.size : 10
      @top_places = Place.places_with_highest_ratings(number)
      erb :top
    end

    post '/vote' do
      Rating.add_rating :user_id => User.current_user.id,
                        :place_id => params[:place_id].to_i,
                        :value => params[:vote].to_i
      
      redirect "/#{params[:place_id]}"
    end
  end
end