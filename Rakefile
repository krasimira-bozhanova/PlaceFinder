require "active_record"

# $ rake db:connect # connect to the db
# $ rake db:migrate # run migrations
# $ rake db:drop # delete the db
# $ rake db:reset # combination of the upper three
# $ rake db:schema # creates a schema file of the current database
# $ rake g:migration your_migration # generates a new migration file

namespace :db do

  db_config = YAML::load(File.open('db/config/database.yml'))
  environment = ENV['environment'] || 'development'

  desc "Create the database"
  task :connect do
    ActiveRecord::Base.establish_connection(db_config[environment])
    #ActiveRecord::Base.connection.create_database(db_config[environment])
    puts "Database created."
  end

  desc "Migrate the development database"
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config['development'])
    ActiveRecord::Migrator.migrate("db/migrate/")
    Rake::Task["db:schema"].invoke
    puts "Database migrated."
  end

  desc "Migrate the test database"
  task :test_migrate do
    ActiveRecord::Base.establish_connection(db_config['test'])
    ActiveRecord::Migrator.migrate("db/migrate/")
    Rake::Task["db:schema"].invoke
    puts "Database migrated."
  end

  desc "Drop the database"
  task :drop do
    ActiveRecord::Base.establish_connection(db_config[environment])
    ActiveRecord::Base.connection.drop_database(db_config[environment])
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

namespace :tests do
  desc 'Starts watchr'
  task :watch do
    system 'watchr watchr.rb'
  end

  require 'rspec/core'
  require 'rspec/core/rake_task'
  desc 'Run unit specs'
  puts "In task"
  RSpec::Core::RakeTask.new('unit') do |t|
    # t.ruby_opts = '-w'
    t.pattern = FileList['spec/placefinder/*_spec.rb']
  end

end