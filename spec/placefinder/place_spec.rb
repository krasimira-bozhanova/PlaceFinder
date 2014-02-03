require_relative '../../spec/rspec_config'
require_relative '../../models/place'

puts "In place_spec"

describe "Place" do

  describe "add_place" do
    it "adds a place successfully" do
      expect do
        Place.add_place(
          :name => "The place",
          :address_id => 1,
          :type_id => 1,
          :residential_complex_id => 1)
      end.to change(Place, :count).by(1)
    end
  end

  describe 'get_place' do
    it 'gets the correct place' do
      place = FactoryGirl.create(:place)
      Place.get_place(
        :name => "Cool place",
        :address_id => 1,
        :type_id => 1
        )['id'].should eq place.id
    end

    it 'returns nil is there is no places in the database' do
      Place.get_place(:name => "Cool place", :address_id => 1, :type_id => 1).should eq nil
    end

    it 'returns nil is there is no such place' do
      place = FactoryGirl.create(:place)
      Place.get_place(:name => "Cool place", :address_id => 2, :type_id => 1).should eq nil
    end
  end

  describe 'get_place_by_id' do
    it "returns nil if there is no place with this id" do
      Place.get_place_by_id(1).should eq nil
    end

    it "returns the right id when there is such a place" do
      place = FactoryGirl.create(:place)
      Place.get_place_by_id(1)["name"].should eq "Cool place"
    end
  end

  describe 'get_all_places_with_type' do
    it 'works with places of the same type' do
      FactoryGirl.create(:place)
      FactoryGirl.create(:place)
      Place.get_all_places_with_type(1).size.should eq 2
    end

    it 'works with places of the same type' do
      FactoryGirl.create(:place)
      FactoryGirl.create(:place_type2)
      Place.get_all_places_with_type(1).size.should eq 1
      Place.get_all_places_with_type(2).size.should eq 1
    end
  end

  describe 'filter' do
    it 'returns nothing when there are no such places' do
      FactoryGirl.create(:place)
      FactoryGirl.create(:place_type2)
      Place.filter(1, 2).size.should eq 0
    end

    it 'works when the type is not specified' do
      FactoryGirl.create(:place)
      FactoryGirl.create(:place_type2)
      Place.filter(0, 1).size.should eq 2
    end

    # it 'works when the residential complex is not specified' do
    #   FactoryGirl.create(:place_type1)
    #   FactoryGirl.create(:place_type2)
    #   Place.filter(0, 1).size.should eq 1
    # end


  end
end