module PlaceFinder
  class ResidentialComplex < ActiveRecord::Base
    class << self

      # Adds a residential complex to the residential_complexes table
      def add_residential_complex(name:)
        unless name.empty?
          create(:name => name)
        end
      end

      # Returns the residential complex name for a given id
      def residential_complex_name(id)
        unless where(:id => id).empty?
          where(:id => id).first.name
        end
      end
    end
  end
end