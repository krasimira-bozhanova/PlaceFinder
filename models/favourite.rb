module PlaceFinder
  class Favourite < ActiveRecord::Base
    class << self

      # Adds the place with id = place_id to the favourite
      # places of user with id = user_id
      def add_favourite(user_id:, place_id:)
        unless user_id < 1 or place_id < 1
          unless already_favourite?(user_id, place_id)
            create(:user_id => user_id,
                   :place_id => place_id)
          end
        end
      end

      # Gets the ids of the favourites places for a user
      def favourite_places_for_user(user_id)
        where(:user_id => user_id).map(&:place_id)
      end

      # Removes the place with id = place_id from the
      # favourite places of the user with id = user_id
      def remove_favourite(user_id, place_id)
        where(["user_id = ? AND place_id = ?", user_id, place_id]).destroy_all
      end

      # Return true if the user has already added
      # this place to his favourites places
      def already_favourite?(user_id, place_id)
        not where(:user_id => user_id, :place_id => place_id).empty?
      end
    end
  end
end
