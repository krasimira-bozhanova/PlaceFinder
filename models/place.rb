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
  end
end
