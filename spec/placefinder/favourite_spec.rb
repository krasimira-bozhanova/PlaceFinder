require_relative '../spec_helper'

module PlaceFinder
  describe "Favourite" do
    describe "add_favourite" do
      it "adds a favourite place successfully" do
        expect do
          Favourite.add_favourite(:place_id => 1, :user_id => 1)
        end.to change(Favourite, :count).by(1)
      end
    end

    describe 'favourite_places_for_user' do
      it 'gets the right ids if there is one favourite place' do
        favourite = FactoryGirl.create(:favourite1)
        Favourite.favourite_places_for_user(1).should eq [favourite.place_id]
      end

      it 'gets the right ids if there are more than one favourite places' do
        favourite1 = FactoryGirl.create(:favourite1)
        favourite2 = FactoryGirl.create(:favourite1_2)
        Favourite.favourite_places_for_user(1).should eq [favourite1.place_id, favourite2.place_id]
      end

      it 'works with more than one user' do
        favourite1 = FactoryGirl.create(:favourite1_2)
        favourite2 = FactoryGirl.create(:favourite2)
        Favourite.favourite_places_for_user(1).should eq [favourite1.place_id]
        Favourite.favourite_places_for_user(2).should eq [favourite2.place_id]
      end
    end

    describe 'remove_favourite' do
      it 'works when there is one favourite place for the user' do
        favourite1 = FactoryGirl.create(:favourite1)
        Favourite.remove_favourite(favourite1.user_id, favourite1.place_id)
        Favourite.favourite_places_for_user(favourite1.user_id).should eq []
      end

      it 'works when there are more than one favourite places for the user' do
        favourite1 = FactoryGirl.create(:favourite1)
        favourite2 = FactoryGirl.create(:favourite1_2)
        Favourite.remove_favourite(favourite1.user_id, favourite1.place_id)
        Favourite.favourite_places_for_user(favourite1.user_id).should eq [favourite2.place_id]
      end
    end

    describe 'already_favourite?' do
      it 'returns false if there are no entries' do
        Favourite.already_favourite?(1,2).should eq false
      end

      it 'returns true is the user has markes the place as favourite' do
        favourite1 = FactoryGirl.create(:favourite1)
        Favourite.already_favourite?(favourite1.user_id, favourite1.place_id).should eq true
      end

      it 'returns false is the user has marked another place as favourite' do
        favourite1 = FactoryGirl.create(:favourite1)
        Favourite.already_favourite?(favourite1.user_id, 2).should eq false
      end
    end
  end
end