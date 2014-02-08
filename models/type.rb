class Type < ActiveRecord::Base

  class << self

    def add_type(name:, plural_name:)
      puts "Adding type"
      unless plural_name.empty? or name.empty?
        create(:name => name, :plural_name => plural_name)
      end
    end

    def get_type_name_by_id(type_id)
      where(:id => type_id).first.name
    end
  end
end