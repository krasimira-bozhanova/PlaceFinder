require_relative '../spec_helper'

module PlaceFinder
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

    describe 'place_by_id' do
      it "returns nil if there is no place with this id" do
        Place.place_by_id(1).should eq nil
      end

      it "returns the right place when there is a place with this id" do
        place = FactoryGirl.create(:place)
        Place.place_by_id(1).should eq place
      end
    end

    describe 'places_with_type' do
      it 'works with places of the same type' do
        place = FactoryGirl.create(:place)
        place1 = FactoryGirl.create(:place)
        Place.places_with_type(1).size.should eq 2
        Place.places_with_type(1).should eq [place, place1]
      end

      it 'works with places with different types' do
        place1 = FactoryGirl.create(:place)
        place2 = FactoryGirl.create(:place_type2)
        Place.places_with_type(1).size.should eq 1
        Place.places_with_type(1).should eq [place1]
        Place.places_with_type(2).size.should eq 1
        Place.places_with_type(2).should eq [place2]
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

      it 'works when the residential complex is not specified' do
        FactoryGirl.create(:place)
        FactoryGirl.create(:place_type2)
        Place.filter(1, 0).size.should eq 1
      end

      it 'returns the places that covers all the requirements' do
        FactoryGirl.create(:place)
        place = FactoryGirl.create(:place_type2)
        Place.filter(2, 1).should eq [place]
      end
    end

    describe 'places_with_highest_ratings' do
      it 'returns an empty array if there are no places' do
        Place.places_with_highest_ratings(1).should eq []
      end

      it 'returns an empty array if there are no places and we request more than one place' do
        Place.places_with_highest_ratings(3).should eq []
      end

      it 'gets the right places when there is more than one place' do
        place1 = FactoryGirl.create(:place)
        place2 = FactoryGirl.create(:place_type2)
        Rating.add_rating(:user_id => 1, :place_id => 1, :value => 5)
        Rating.add_rating(:user_id => 1, :place_id => 2, :value => 5)
        Rating.add_rating(:user_id => 2, :place_id => 1, :value => 4)
        Place.places_with_highest_ratings(1).should eq [place2]
      end
    end

    describe 'newest_places' do

      it 'returns nil if there are no places' do
        Place.newest_places(3).should eq []
      end

      it 'returns the newest places correctly' do
        place1 = FactoryGirl.create(:place)
        place2 = FactoryGirl.create(:place_type2)
        Place.newest_places(1).should eq [place2]
      end

      it 'returns all the places if the number requested is greater than all the places in the database' do
        place1 = FactoryGirl.create(:place)
        place2 = FactoryGirl.create(:place_type2)
        Place.newest_places(3).should eq [place1, place2]
      end
    end
  end
end