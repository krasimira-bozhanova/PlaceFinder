require_relative '../db/connect'

class Address < ActiveRecord::Base

  class << self

    def add_address(zhk:, street:, street_number:)
      unless [zhk, street].any?(&:empty?) or street_number < 1
          create(:place_id => -1,
                 :zhk => zhk,
                 :street => street,
                 :street_number => street_number)
      end
    end

    def add_place_id_to_address(place_id, address_id)
      update(address_id, :place_id => place_id)
    end

    def get_address_by_place_id(place_id)
      where(:place_id => place_id)
    end

    def get_address_id(zhk:, street:, street_number:)
      where(:zhk => zhk, :street => street, :street_number => street_number).first.id
    end

  end
end
