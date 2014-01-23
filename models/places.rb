class Place < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy

  class << self

    def add_place(name:, address:, type:, description: nil)
      unless [name, address, type].any?(&:empty?)
          create(:name => name,
                 :address => address,
                 :type => type,
                 :description => description)
    end

    def get_place(name:, address:, type:, description: nil)
      unless [name, address, type].any?(&:empty)
          create(:name => name,
                 :address => address,
                 :type => type,
                 :description => description)
    end

  end
end