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

    get %r{/(\d+)} do
      @place = Place.place_by_id(params[:captures].first)
      @place_type = Type.type_name_by_id(@place.type_id)
      @is_favourite = Favourite.already_favourite?(
        User.current_user.id, @place.id)
      @address = Address.address_by_place_id @place.id
      @residential_complex_name = ResidentialComplex.residential_complex_name(
        @address.residential_complex_id)
      @pictures_for_place = Picture.pictures_for_place(@place.id)
      @comments = Comment.comments_of_place(@place.id)
      rating = Rating.rating_of_place @place.id
      @rating = rating == nil ? "Все още не е гласувано" : rating
      @voted_already = Rating.voted_already?(User.current_user.id, @place.id)
      erb :show_place
    end

    get '/top' do
      number = Place.all.size < 10 ? Place.all.size : 10
      @top_places = Place.places_with_highest_ratings(number)
      erb :top
    end
  end
end