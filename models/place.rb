require 'date'

module PlaceFinder
  class Place < ActiveRecord::Base
    has_many :pictures, :dependent => :destroy

    class << self

      # Adds a place to the places table
      # If a picture or the place is not specified
      # then it is given a defaulf one
      def add_place(name:, address_id:, type_id:, residential_complex_id:,
                    main_picture_path:"img1.png", description: nil)
        unless name.empty? or type_id < 1 or
          residential_complex_id < 1 or address_id < 1

          create(
            :name => name, :address_id => address_id, :type_id => type_id,
            :description => description, :date => DateTime.now,
            :residential_complex_id => residential_complex_id,
            :main_picture_path => main_picture_path
            )
        end
      end

      # Returns the place with the given id
      def place_by_id(place_id)
        where(:id => place_id).first
      end

      # Returns all places with the type specified
      def places_with_type(type_id)
        where(:type_id => type_id)
      end

      # Returns a place with type_id and/or residential_complex_id
      # If any of the parametes is <= 0 the places are not
      # filtered for this parameter
      def filter(type_id, residential_complex_id)
        quered_object = self
        if type_id > 0
          quered_object = quered_object.where(:type_id => type_id)
        end
        if residential_complex_id > 0
          quered_object = quered_object.where(
            :residential_complex_id => residential_complex_id)
        end
        quered_object
      end

      # Returns the places with highest rating
      def places_with_highest_ratings(number)
        Rating.place_ids_with_highest_rating(number).map { |id| place_by_id id }
      end

      # Returns the newest places
      def newest_places(number)
        real_number = number > all.size ? all.size : number
        all.sort_by(&:date).drop(all.size - real_number)
      end
    end
  end
end
