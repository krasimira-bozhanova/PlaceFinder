require 'digest/sha1'
require_relative 'exceptions'

class User < ActiveRecord::Base
  class << self

    def add_user(username:, password:, name:)
      unless [username, password, name].any?(&:empty?)
        create(:username => username,
               :password => Digest::SHA1.hexdigest(password),
               :name => name,
               :login => false,
               :admin => false)
      end
    end

    def get_current_user
      where(:login => true).map { |user| user.attributes }.first
    end

    def get_id_from_username(username)
      user = where(:username => username).first
      user.nil? ? 0 : user.id
    end

    def get_username_from_id(user_id)
      where(:id => user_id).first.username
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
      update(get_current_user['id'], :login => false)
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

    def is_there_current_user
      not where(:login => true).empty?
    end

    def get_current_user_name
      get_current_user["name"]
    end

    def is_username_available(username)
      where(:username => username).empty?
    end

    def register_user(username, password, repeat_password, name)
      if password != repeat_password
        raise PasswordFailure, 'Грешна парола'
      elsif [username, password, name].any?(&:empty?)
        raise EmptyField, 'Моля, попълнете всички полета'
      elsif not is_username_available(username)
        raise UsernameDuplicate, 'Вече има потребител с такова потребителско име'
      else
        add_user(:username => username,
                 :password => password,
                 :name => name)
      end
    end
  end
end
