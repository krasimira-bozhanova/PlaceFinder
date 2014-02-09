module PlaceFinder
  class Address < ActiveRecord::Base
    class << self

      # Adds an address to the addresses table
      def add_address(residential_complex_id:, street:, street_number:)
        unless residential_complex_id < 1 or street.empty? or street_number < 1
            create(:place_id => -1,
                   :residential_complex_id => residential_complex_id,
                   :street => street,
                   :street_number => street_number)
        end
      end

      # Adds a place_id to an address if the place_id field has not been set yet
      def add_place_id_to_address(place_id, address_id)
        if where(:id => address_id).first.place_id == -1
          update(address_id, :place_id => place_id)
        end
      end

      # Gets an address by place_id
      def address_by_place_id(place_id)
        where(:place_id => place_id).first
      end

      # Gets an address_id with according to the parameters
      # If no such address is found then returns nil
      def address_id(residential_complex_id:, street:, street_number:)
        filtered_result = where(
          :residential_complex_id => residential_complex_id,
          :street => street,
          :street_number => street_number)
        unless filtered_result.empty?
          filtered_result.first.id
        end
      end
    end
  end
end
