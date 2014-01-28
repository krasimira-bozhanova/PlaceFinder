class Comment < ActiveRecord::Base

  class << self

    def add_comment(user_id:, place_id:, comment:)
      unless user_id < 1 or place_id < 0 or comment.empty?
          create(:user_id => user_id,
                 :place_id => place_id,
                 :comment => comment)
      end
    end

    def get_comments_of_place(place_id)
      where(:place_id => place_id).each_with_object([]) do |comment, all_comments|
        all_comments.push comment.attributes
      end
    end

  end
end