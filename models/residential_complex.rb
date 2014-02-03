class ResidentialComplex < ActiveRecord::Base

  class << self
    def add_residential_complex(name:)
      unless name.empty?
        create(:name => name)
      end
    end
  end
end