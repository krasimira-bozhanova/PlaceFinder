require 'digest/sha1'
require_relative 'exceptions'

module PlaceFinder
  class User < ActiveRecord::Base
    class << self

      # Adds a user to the users table
      def add_user(username:, password:, name:)
        unless [username, password, name].any?(&:empty?)
          create(:username => username,
                 :password => Digest::SHA1.hexdigest(password),
                 :name => name,
                 :login => false,
                 :admin => false)
        end
      end

      # Returns the currently logged in user
      def current_user
        where(:login => true).first
      end

      # Returns the id of a user with given username
      # If such a user doesn't exist then returns nil
      def id_from_username(username)
        where(:username => username).map(&:id).first
      end

      # Returns the username of a user with given id
      # If such a user doesn't exist then returns nil
      def username_from_id(user_id)
        where(:id => user_id).map(&:username).first
      end

      # Logs in a user with a give username and password
      # If the loggin is successful returns true, else - false
      def login(username, password)
        unless empty_or_whitespace?(username, password)
          encrypted_password = Digest::SHA1.hexdigest(password)
          if exists?(:username => username, :password => encrypted_password)
            update(id_from_username(username), :login => true)
            return true
          end
        end
        false
      end

      # Logs out the currently logged in user
      def logout
        update(current_user.id, :login => false)
      end

      # Returns the name of a user with a given username
      # If no such user exists then returns nil
      def name_from_username(username)
        where(:username => username).map(&:name).first
      end

      # Returns true if there is currently logged in user
      # Returns else otherwise
      def is_there_current_user
        not where(:login => true).empty?
      end

      # Registers user with a given name, pass and username
      # Raises exception if the fields are not filled in properly
      def register_user(username, password, repeat_password, name)
        validate_registry(username, password, repeat_password, name)
        add_user(:username => username,
                 :password => password,
                 :name => name)
        login(username, password)
      end

      private

      # Returns true if the diven username has not been used yet
      def is_username_available(username)
        where(:username => username).empty?
      end

      # Returns true if there is an argument form the given ones
      # which is empty or contains only whitespace
      def empty_or_whitespace?(*fields)
        fields.map { |field| /^\s*$/.match field }.any? ? true : false
      end

      # Raises an exception with an appropriate message if one of
      # the followings is met:
      # - the filled in password and repeat_password fields are not the same
      # - there is a registered user with the same username
      # - there is a field which is empty or contains only whitespace
      # characters
      def validate_registry(username, password, repeat_password, name)
        if empty_or_whitespace?(username, password, name)
          raise EmptyField, 'Моля, попълнете всички полета'
        end
        raise PasswordFailure, 'Грешна парола' if password != repeat_password
        if not is_username_available(username)
          raise UsernameDuplicate,
            'Вече има потребител с такова потребителско име'
        end
      end
    end
  end
end