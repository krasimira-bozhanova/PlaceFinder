require 'active_record'
require_relative '../models/placefinder'


["Изгрев", "Лозенец", "Изток", "Младост 1", "Дианабат"].each do |complex|
  ResidentialComplex.add_residential_complex(:name => complex)
end

type_ids = []
["кафене", "ресторант", "бар", "заведение за бързо хранене"].each do |type|
  type_ids << Type.add_type(:name => type).id
end

User.add_user(:username => "krasi", :password => "krasi", :name => "Krasi")

address = Address.add_address(:residential_complex_id => 2, :street => "Джеймс Баучер", :street_number => 76)
place = Place.add_place(:name => "Табиет",
                        :address_id => address.id,
                        :type_id => 1,
                        :residential_complex_id => 2,
                        :main_picture_path => "img/tabiet.jpg")
picture = Picture.add_picture(:place_id => place.id, :picture_path => "img/tabiet.jpg")

