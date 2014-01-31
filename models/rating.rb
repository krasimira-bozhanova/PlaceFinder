class Rating < ActiveRecord::Base

  class << self

    def add_rating(place_id:, user_id:, value:)
      unless place_id < 1 or user_id < 1 or value > 5 or value < 1
        unless has_this_user_voted_yet(user_id, place_id)
          create(:place_id => place_id,
                 :user_id => user_id,
                 :value => value)
        end
      end
    end

    def get_rating_of_place(place_id)
      unless where(:place_id => place_id).empty?
        all_ratings = where(:place_id => place_id).map { |rating| rating.value }
        all_ratings.reduce(&:+) / all_ratings.size
      end
    end

    def has_this_user_voted_yet(user_id, place_id)
      not where(:user_id => user_id, :place_id => place_id).empty?
    end

    def get_place_ids_with_highest_rating(number)
      places_hash = {}
      select(:place_id).map { |rating| rating[:place_id] } .each do |place_id|
        places_hash[place_id] = get_rating_of_place place_id
      end
      places_hash.sort_by { |key, value| -value }.take(number)
    end

  end
end
