module PlaceFinder
  class Picture < ActiveRecord::Base
    class << self

      def add_picture(place_id:, picture_path:)
        create(:place_id => place_id,
               :picture_path => picture_path)
      end

      def pictures_for_place(place_id)
        unless where(:place_id => place_id).empty?
          where(:place_id => place_id)
        end
      end
    end
  end
end
