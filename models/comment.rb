require 'date'

module PlaceFinder
  class Comment < ActiveRecord::Base
    class << self

      # Adds a comment to the comments table
      def add_comment(user_id:, place_id:, comment:)
        unless user_id < 1 or place_id < 0 or not validate_comment(comment)
            create(:user_id => user_id,
                   :place_id => place_id,
                   :comment => comment,
                   :date => DateTime.now)
        end
      end

      # Gets all the comments of a place ordered by date
      def comments_of_place(place_id)
        where(:place_id => place_id).sort_by(&:date)
      end

      # Returns false if the comment is an empty string or
      # contains only whitespace characters
      def validate_comment(comment)
        /^\s*$/.match(comment).nil? ? true : false
      end
    end
  end
end