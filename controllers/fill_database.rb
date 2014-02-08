require 'active_record'
require_relative '../models/placefinder'


["Изгрев", "Лозенец", "Изток", "Център", "Младост 1", "Дианабат", "Борово", "Б18", "Света Тройца"].each do |complex|
  ResidentialComplex.add_residential_complex(:name => complex)
end

type_ids = []
{
    "Kафене" => "Кафенета",
    "Ресторант" => "Ресторанти",
    "Бар" => "Барове",
    "Заведение за бързо хранене" => "Заведения за бързо хранене",
	"Пицария" => "Пицарии",
    "Механа" => "Механи",
    "Нощен клуб" => "Нощни клубове"
}.each do |key, value|
  type_ids << Type.add_type(:name => key, :plural_name => value).id
end

User.add_user(:username => "krasi", :password => "krasi", :name => "Krasi")

address1 = Address.add_address(:residential_complex_id => 2, :street => "бул. Джеймс Баучер", :street_number => 76)
address2 = Address.add_address(:residential_complex_id => 3, :street => "ул. Доктор Любен Русев", :street_number => 6)
address3 = Address.add_address(:residential_complex_id => 4, :street => "бул. Скобелев", :street_number => 62)


place = Place.add_place(:name => "Табиет",
                        :address_id => address1.id,
                        :type_id => 2,
                        :residential_complex_id => 2,
                        :main_picture_path => "img/tabiet.jpg",
                        :description => "Ресторант градина „Табиет” е носител на престижната награда на Българска Хотелиерска и Ресторантьорска Асоциация БХРА- Ресторант на годината 2005 и на наградата –
Ресторантьорска верига на годината 2006 заедно с първия ресторант ТАБИЕТ,който за съжаление прекрати своята дейност през лятото на 2012г. ")
Address.add_place_id_to_address(place.id, address1.id)

place2 = Place.add_place(:name => "Dell Arte",
                        :address_id => address2.id,
                        :type_id => 2,
                        :residential_complex_id => 3,
                        :main_picture_path => "img/dellarte.jpg")
Address.add_place_id_to_address(place2.id, address2.id)

place3 = Place.add_place(:name => "ELIDIS",
                        :address_id => address3.id,
                        :type_id => 1,
                        :residential_complex_id => 4,
                        :main_picture_path => "img/elidis.jpg",
                        :description => "Страхотно кафе, паркинг, климатик, приятна музика, вкуснотийки, идеално място за частни партита и бизнес срещи.")
Address.add_place_id_to_address(place3.id, address3.id)

Picture.add_picture(:place_id => place.id, :picture_path => "img/tabiet.jpg")
Picture.add_picture(:place_id => place.id, :picture_path => "img/tabiet1.jpg")
Picture.add_picture(:place_id => place.id, :picture_path => "img/tabiet2.jpg")

Picture.add_picture(:place_id => place2.id, :picture_path => "img/dellarte.jpg")
Picture.add_picture(:place_id => place2.id, :picture_path => "img/dellarte1.jpg")
Picture.add_picture(:place_id => place2.id, :picture_path => "img/dellarte2.jpg")

Picture.add_picture(:place_id => place3.id, :picture_path => "img/elidis.jpg")

["Страхотно място", "Вкусна кухня"].each do |comment|
  Comment.add_comment(:user_id => 1, :place_id => 1, :comment => comment)
end

