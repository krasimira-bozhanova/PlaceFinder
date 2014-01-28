require 'active_record'

class Type < ActiveRecord::Base

  class << self

    def add_type(name:)
      unless name.empty?
        create(:name => name)
      end
    end

  end
end