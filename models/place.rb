require 'date'

class Place < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy

  class << self

    def add_place(name:, address_id:, type_id:, residential_complex_id:, main_picture_path:"", description: nil)
      unless name.empty? or type_id < 1 or residential_complex_id < 1 or address_id < 1
        if main_picture_path.empty?
          main_picture_path = 'img/img1.png'
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
            :type_id => type_id).map(&:attributes).first
    end

    def get_place_by_id(place_id)
      where(:id => place_id).map(&:attributes).first
    end

    def get_places_with_highest_ratings(number)
      ids = Rating.get_place_ids_with_highest_rating(number).map(&:last)
      ids.map { |id| get_place_by_id id }
    end

    def get_all_places_with_type(type_id)
      where(:type_id => type_id).map(&:attributes)
    end

    def filter(type_id, residential_complex_id)
      quered_object = self
      if type_id > 0
        quered_object = quered_object.where(:type_id => type_id)
        puts "In type_id > 0"
        puts quered_object.inspect
      end
      if residential_complex_id > 0
        quered_object = quered_object.where(:residential_complex_id => residential_complex_id)
        puts "In rc > 0"
        puts quered_object.inspect
      end
      quered_object.map(&:attributes)
    end

  end
end
