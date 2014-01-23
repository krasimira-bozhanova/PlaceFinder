require 'active_record'
require '../db/connect'


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

new_address = Address.add_address(:address => {
  :zhk => 'Izgrev',
  :street => 'Some street',
  :street_number => '1',
  })

puts new_address.inspect
Address.add_place_id_to_address(1, new_address.id)
a = Address.get_address_by_place_id(1)

puts a.inspect
