require 'digest/sha1'
require 'date'
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

  factory :type_restaurant, class: Type do
    name 'restaurant'
  end

  factory :type_cafe, class: Type do
    name 'cafe'
  end

  factory :place, class: Place do
    name 'Cool place'
    address_id 1
    type_id 1
    description "Cool place"
    residential_complex_id 1
    main_picture_path "some/path"
    date DateTime.now
  end

  factory :place_type2, class: Place do
    name 'Cool place'
    address_id 1
    type_id 2
    description "Cool place"
    residential_complex_id 1
    main_picture_path "some/path"
    date DateTime.now
  end

  # factory :address, class: Address do
  #   place_id 1
  #   zhk 'Izgrev'
  #   street 'Some street'
  #   street_number 1
  # end
end