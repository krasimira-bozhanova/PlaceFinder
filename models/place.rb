require 'date'

module PlaceFinder
  class Place < ActiveRecord::Base
    has_many :pictures, :dependent => :destroy

    class << self
      def add_place(name:, address_id:, type_id:, residential_complex_id:, main_picture_path:"", description: nil)
        unless name.empty? or type_id < 1 or residential_complex_id < 1 or address_id < 1
          if main_picture_path.empty?
            main_picture_path = 'img1.png'
          end
          create(:name => name,
                 :address_id => address_id,
                 :type_id => type_id,
                 :description => description,
                 :date => DateTime.now,
                 :residential_complex_id => residential_complex_id,
                 :main_picture_path => main_picture_path)
        end
      end

      def get_place(name:, address_id:, type_id:)
        where(:name => name,
              :address_id => address_id,
              :type_id => type_id).first
      end

      def place_by_id(place_id)
        where(:id => place_id).first
      end

      def places_with_type(type_id)
        where(:type_id => type_id)
      end

      def filter(type_id, residential_complex_id)
        quered_object = self
        if type_id > 0
          quered_object = quered_object.where(:type_id => type_id)
        end
        if residential_complex_id > 0
          quered_object = quered_object.where(:residential_complex_id => residential_complex_id)
        end
        quered_object
      end

      def places_with_highest_ratings(number)
        Rating.place_ids_with_highest_rating(number).map { |id| place_by_id id }
      end

      def newest_places(number)
        real_number = number > all.size ? all.size : number
        all.sort_by(&:date).drop(all.size - real_number)
      end
    end
  end
end
