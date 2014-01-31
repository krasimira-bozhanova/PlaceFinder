require 'digest/sha1'

class User < ActiveRecord::Base
  class << self

    def add_user(username:, password:, name:)
      unless [username, password, name].any?(&:empty?)
        create(:username => username,
               :password => password,
               :name => name,
               :login => false,
               :admin => false)
      end
    end

    def get_current_user
      where(:login => true)
    end

    def get_id_from_username(username)
      user = where(:username => username).first
      user.nil? ? 0 : user.id
    end

    def login(username, password)
      if validate_input_login username, password
        encrypted_password = Digest::SHA1.hexdigest(password)
        if exists?(:username => username, :password => encrypted_password)
          user_id = id_from_username(username)
          update(user_id, :login => true)
          return true
        end
      end
      false
    end

    def logout
      update(get_current_user.id, :login => false)
    end

    def get_favourite_places_for_user
    end

    def validate_input_login(username, password)
      [username, password].none?(&:empty?)
    end

    def id_from_username(username)
      where(:username => username).map { |user| user.attributes['id'] }.first
    end

    def name_from_username(username)
      where(:username => username).map { |user| user.attributes['name'] }.first
    end

    def has_current_user
      not where(:login => true).nil?
    end

    def get_current_user_name
      where(:login => true).map { |user| user.name }.first
    end

  end
end
