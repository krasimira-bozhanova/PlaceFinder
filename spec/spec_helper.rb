require 'database_cleaner'
require 'rspec'
require 'digest/sha1'
require 'date'

ENV['environment'] = 'test'

require_relative '../models/placefinder'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

# Set up FactoryGirl
require 'factory_girl'
FactoryGirl.find_definitions