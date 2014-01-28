require_relative '../db/connect'


class User < ActiveRecord::Base

  class << self

    def add_user(username:, password:, name:)
      unless [username, password, name].any?(&:empty?)
          create(:username => username,
                 :password => password,
                 :name => name)
      end
    end

  end
end
