require 'active_record'
#require 'yaml'

db_config = YAML::load(File.open(File.expand_path(File.dirname(__FILE__)) + '/config/database.yml'))
environment = ENV['environment'] || 'development'

ActiveRecord::Base.establish_connection(db_config[environment])

