require 'date'

class Comment < ActiveRecord::Base

  class << self

    def add_comment(user_id:, place_id:, comment:)
      unless user_id < 1 or place_id < 0 or comment.empty?
          create(:user_id => user_id,
                 :place_id => place_id,
                 :comment => comment,
                 :date => DateTime.now)
      end
    end

    def comments_of_place(place_id)
      where(:place_id => place_id).sort_by(&:date)
    end

  end
end