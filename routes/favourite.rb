module PlaceFinder
  class PlaceFinder < Sinatra::Base
    post "/add_to_favourites" do
      Favourite.add_favourite :user_id => User.current_user.id,
                              :place_id => params[:place_id].to_i
      redirect "/#{params[:place_id]}"
    end

    post "/remove_from_favourites" do
      Favourite.remove_favourite User.current_user.id, params[:place_id].to_i
      redirect "/#{params[:place_id]}"
    end

    get "/favourites" do
      favourite_places_ids = Favourite.favourite_places_for_user(User.current_user.id)
      @favourite_places = favourite_places_ids.map { |place_id| Place.place_by_id place_id }
      erb :favourites
    end
  end
end