require 'digest/sha1'
require_relative 'exceptions'

module PlaceFinder
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

      def current_user
        where(:login => true).first
      end

      def id_from_username(username)
        where(:username => username).map(&:id).first
      end

      def username_from_id(user_id)
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
        update(current_user.id, :login => false)
      end

      def favourite_places_for_user
      end

      def validate_input_login(username, password)
        [username, password].none?(&:empty?)
      end

      def name_from_username(username)
        where(:username => username).map(&:name).first
      end

      def is_there_current_user
        not where(:login => true).empty?
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
          login(username, password)
        end
      end
    end
  end
end