require_relative '../db/connect'


class Address < ActiveRecord::Base

  class << self

    def add_address(address:)
      unless address.empty?
          create(:place_id => -1,
                 :zhk => address[:zhk],
                 :street => address[:street],
                 :street_number => address[:street_number])
      end
    end

    def add_place_id_to_address(place_id, address_id)
      update(address_id, :place_id => place_id)
    end

    def get_address_by_place_id(place_id)
      where(:place_id => place_id)
    end

  end
end
