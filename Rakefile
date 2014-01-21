#require 'sinatra/activerecord/rake'

# namespace :db do
#   task :environment do
#     require 'active_record'
#     ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database =>  'db/test.sqlite3.db'
#   end

#   desc "Migrate the database"
#   task(:migrate => :environment) do
#     ActiveRecord::Base.logger = Logger.new(STDOUT)
#     ActiveRecord::Migration.verbose = true
#     ActiveRecord::Migrator.migrate("db/migrate")
#   end
# end

# require 'active_record'
# require 'yaml'

# task :default => :migrate

# desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
# task :migrate => :environment do
#   ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
# end

# task :environment do
#   #ActiveRecord::Base.establish_connection(YAML::load(File.open('database.yml')))
#   ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database =>  'db/test.sqlite3.db'
#   ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
# end



# $ rake db:create # create the db
# $ rake db:migrate # run migrations
# $ rake db:drop # delete the db
# $ rake db:reset # combination of the upper three
# $ rake db:schema # creates a schema file of the current database
# $ rake g:migration your_migration # generates a new migration file

require "active_record"

namespace :db do

  db_config = YAML::load(File.open('db/config/database.yml'))
  environment = ENV['environment'] || 'development'

  desc "Create the database"
  task :create do
    ActiveRecord::Base.establish_connection(db_config[environment])
    #ActiveRecord::Base.connection.create_database(db_config["database"])
    puts "Database created."
  end

  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config[environment])
    ActiveRecord::Migrator.migrate("db/migrate/")
    Rake::Task["db:schema"].invoke
    puts "Database migrated."
  end

  desc "Drop the database"
  task :drop do
    ActiveRecord::Base.establish_connection(db_config_admin)
    ActiveRecord::Base.connection.drop_database(db_config["database"])
    puts "Database deleted."
  end

  desc "Reset the database"
  task :reset => [:drop, :create, :migrate]

  desc 'Create a db/schema.rb file that is portable against any DB supported by AR'
  task :schema do
    ActiveRecord::Base.establish_connection(db_config[environment])
    require 'active_record/schema_dumper'
    filename = "db/schema.rb"
    File.open(filename, "w:utf-8") do |file|
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
    end
  end

end

namespace :g do
  desc "Generate migration"
  task :migration do
    name = ARGV[1] || raise("Specify name: rake g:migration your_migration")
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split("_").map(&:capitalize).join

    File.open(path, 'w')

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end

