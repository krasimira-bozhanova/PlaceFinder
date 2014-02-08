class Favourite < ActiveRecord::Base
  class << self

    def add_favourite(user_id:, place_id:)
      unless user_id < 1 or place_id < 1
        unless already_favourite?(user_id, place_id)
          create(:user_id => user_id,
                 :place_id => place_id)
        end
      end
    end

    def favourite_places_for_user(user_id)
      where(:user_id => user_id).map(&:place_id)
    end

    def remove_favourite(user_id, place_id)
      where(["user_id = ? AND place_id = ?", user_id, place_id]).destroy_all
    end

    def already_favourite?(user_id, place_id)
      not where(:user_id => user_id, :place_id => place_id).empty?
    end
  end
end
