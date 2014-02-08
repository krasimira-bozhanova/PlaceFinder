require 'sinatra/base'
require 'rubygems'

class PlaceFinder < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '.')
  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }
  set :static, true

  after do
    ActiveRecord::Base.connection.close
  end

  require_relative 'routes/init'
end