require 'active_record'
require_relative '../models/placefinder'


["Изгрев", "Лозенец", "Изток", "Център" "Младост 1", "Дианабат", "Борово", "Б18", "Света Тройца"].each do |complex|
  ResidentialComplex.add_residential_complex(:name => complex)
end

type_ids = []
["кафене", "ресторант", "бар", "заведение за бързо хранене",
	"пицария", "механа", "нощен клуб"].each do |type|
  type_ids << Type.add_type(:name => type).id
end

User.add_user(:username => "krasi", :password => "krasi", :name => "Krasi")

address1 = Address.add_address(:residential_complex_id => 2, :street => "Джеймс Баучер", :street_number => 76)
address2 = Address.add_address(:residential_complex_id => 3, :street => "Доктор Любен Русев", :street_number => 6)
place = Place.add_place(:name => "Табиет",
                        :address_id => address1.id,
                        :type_id => 2,
                        :residential_complex_id => 2,
                        :main_picture_path => "img/tabiet.jpg")

place2 = Place.add_place(:name => "Dell Arte",
                        :address_id => address2.id,
                        :type_id => 2,
                        :residential_complex_id => 3,
                        :main_picture_path => "img/dellarte.jpg")

picture = Picture.add_picture(:place_id => place.id, :picture_path => "img/tabiet.jpg")
picture = Picture.add_picture(:place_id => place2.id, :picture_path => "img/dellarte.jpg")

