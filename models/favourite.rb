require_relative '../db/connect'

class Favourites < ActiveRecord::Base
  class << self

    def add_favourite(user_id, place_id)
      unless user_id < 1 or place_id < 1
        create(:user_id => user_id,
               :place_id => place_id)
      end
    end

    def get_favourite_places_for_user(user_id)
      where(:user_id => user_id).map { |favourite| favourite.attributes['place_id'] }
    end

    def remove_favourite(user_id, place_id)
      where(["user_id = ? AND place_id = ?", user_id, place_id]).destroy_all
    end
  end
end
