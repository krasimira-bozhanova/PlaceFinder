module PlaceFinder
  class ResidentialComplex < ActiveRecord::Base
    class << self
      def add_residential_complex(name:)
        unless name.empty?
          create(:name => name)
        end
      end

      def residential_complex_name_by_id(id)
        unless where(:id => id).empty?
          where(:id => id).first.name
        end
      end
    end
  end
end