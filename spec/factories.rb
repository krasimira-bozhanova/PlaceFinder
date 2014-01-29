require 'digest/sha1'
require_relative '../models/placefinder'

puts "In factories"

FactoryGirl.define do
  factory :user, class: User do
    username 'username'
    password Digest::SHA1.hexdigest('password')
    name 'Some User'
    login false
    admin false
  end

  factory :type, class: Type do
    name 'restaurant'
  end

  factory :place, class: Place do
    name 'Cool place'
    type 1
  end

  # factory :address, class: Address do
  #   place_id 1
  #   zhk 'Izgrev'
  #   street 'Some street'
  #   street_number 1
  # end
end