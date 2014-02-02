require 'database_cleaner'
require 'rspec'

puts "In rspec_config"

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.clean
  end
end

# Set up a testing envoronment and off we go
ENV['environment'] = 'test'
require_relative '../db/connect'

# Set up FactoryGirl
require 'factory_girl'
FactoryGirl.find_definitions