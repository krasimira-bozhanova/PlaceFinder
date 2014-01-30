require_relative '../models/address'
require_relative '../models/user'
require_relative '../models/picture'
require_relative '../models/place'
require_relative '../models/comment'

require_relative '../models/type'
require_relative '../models/favourite'


type_ids = []
["кафене", "ресторант", "бар", "заведение за бързо хранене"].each do |type|
  type_ids << Type.add_type(:name => type).id
end

User.add_user(:username => "krasi", :password => "krasi", :name => "Krasi")

address = Address.add_address(:zhk => "Лозенец", :street => "Джеймс Баучер", :street_number => 76)
place = Place.add_place(:name => "Табиет",
                        :address_id => address.id,
                        :type_id => 1)
picture = Picture.add_picture(:place_id => place.id, :picture_path => "tabiet.jpg")

