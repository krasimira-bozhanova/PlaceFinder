class Picture < ActiveRecord::Base
  class << self

    def add_picture(place_id:, picture_path:)
      create(:place_id => place_id,
             :picture_path => picture_path)
    end

    def get_pictures_for_place(place_id)
      where(:place_id => place_id).each_with_object([]) do |picture, array|
        array << picture.attributes
      end
    end

  end
end
