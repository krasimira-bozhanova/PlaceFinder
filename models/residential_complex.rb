class ResidentialComplex < ActiveRecord::Base

  class << self
    def add_residential_complex(name:)
      unless name.empty?
        create(:name => name)
      end
    end

    def get_residential_complex_name(id)
      where(:id => id).first.name
    end
  end
end