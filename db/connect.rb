require 'active_record'
#require 'yaml'


puts "In db connect"

db_config = YAML::load(File.open(File.expand_path(File.dirname(__FILE__)) + '/config/database.yml'))
environment = ENV['environment'] || 'development'

puts "Environment:"
puts environment

ActiveRecord::Base.establish_connection(db_config[environment])

