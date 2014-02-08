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
    name 'Restaurant'
    plural_name 'Restaurants'
  end

  factory :type_cafe, class: Type do
    name 'Cafe'
    plural_name 'Cafes'
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

  factory :residential_complex, class: ResidentialComplex do
    name 'Lozenets'
  end

  factory :picture1, class: Picture do
    place_id 1
    picture_path "aaa.jpg"
  end

  factory :picture1_2, class: Picture do
    place_id 1
    picture_path "bbb.jpg"
  end

  factory :picture2, class: Picture do
    place_id 2
    picture_path "ccc.jpg"
  end

  factory :favourite1, class: Favourite do
    user_id 1
    place_id 1
  end

  factory :favourite1_2, class: Favourite do
    user_id 1
    place_id 2
  end

  factory :favourite2, class: Favourite do
    user_id 2
    place_id 2
  end

  factory :comment1, class: Comment do
    user_id 1
    place_id 1
    comment "Great place"
    date DateTime.now
  end

  factory :comment2, class: Comment do
    user_id 2
    place_id 1
    comment "I agree"
    date DateTime.now
  end

  factory :address, class: Address do
    place_id -1
    residential_complex_id 1
    street 'Some street'
    street_number 1
  end

  factory :address1, class: Address do
    place_id 1
    residential_complex_id 1
    street 'Some street'
    street_number 1
  end

  factory :rating1_1, class: Rating do
    user_id 1
    place_id 1
    value 5
  end

  factory :rating2_1, class: Rating do
    user_id 1
    place_id 1
    value 2
  end
end