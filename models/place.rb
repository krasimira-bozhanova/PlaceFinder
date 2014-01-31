class Place < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy

  class << self

    def add_place(name:, address_id:, type_id:, description: nil)
      unless name.empty? or type_id < 1 or address_id < 1
          create(:name => name,
                 :address_id => address_id,
                 :type_id => type_id,
                 :description => description)
      end
    end

    def get_place(name:, address_id:, type_id:)
      where(:name => name,
            :address_id => address_id,
            :type_id => type_id).first

    end

    def get_place_by_id(place_id)
      where(:id => place_id)
    end

    def get_places_with_highest_ratings(number)
      ids = Rating.get_place_ids_with_highest_rating(number).map(&:last)
      ids.map { |id| get_place_by_id id }
    end

  end
end
