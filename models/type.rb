module PlaceFinder
  class Type < ActiveRecord::Base
    class << self
      def add_type(name:, plural_name:)
        unless plural_name.empty? or name.empty?
          create(:name => name, :plural_name => plural_name)
        end
      end

      def type_name_by_id(type_id)
        unless where(:id => type_id).empty?
          where(:id => type_id).first.name
        end
      end

      def type_plural_name_by_id(type_id)
        unless where(:id => type_id).empty?
          where(:id => type_id).first.plural_name
        end
      end
    end
  end
end