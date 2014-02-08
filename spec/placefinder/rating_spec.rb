require_relative '../../spec/rspec_config'
require_relative '../../models/rating'

puts "In rating_spec"

describe "rating" do

  describe "add_rating" do
    it "adds a rating successfully" do
      expect do
        Rating.add_rating(:user_id => 1, :place_id => 1, :value => 5)
      end.to change(Rating, :count).by(1)
    end
  end

  describe "rating_of_place" do
    it "returns nil if the place doesn't have a rating yet" do
      Rating.rating_of_place(1).should eq nil
    end

    it "returns the right rating when there is only one vote" do
      FactoryGirl.create(:rating1_1)
      Rating.rating_of_place(1).should eq 5
    end
    

    it "returns the right rating when there are multiple votes" do
      FactoryGirl.create(:rating1_1)
      FactoryGirl.create(:rating2_1)
      Rating.rating_of_place(1).should eq 3.5
    end
  end

  describe "has_this_user_voted_yet" do
    it "returns true if this user has already voted for this place" do
      FactoryGirl.create(:rating1_1)
      Rating.has_this_user_voted_yet(1, 1).should eq true
    end

    it "returns false if this user hasn't voted for this place yet" do
      Rating.has_this_user_voted_yet(1, 1).should eq false
    end

    it "returns false if this user has voted for different place" do
      FactoryGirl.create(:rating1_1)
      Rating.has_this_user_voted_yet(1, 2).should eq false
    end
  end

  describe "place_ids_with_highest_rating" do
    it "Selects as many places as said" do
      Rating.add_rating(:user_id => 1, :place_id => 1, :value => 5)
      Rating.add_rating(:user_id => 1, :place_id => 2, :value => 5)
      Rating.add_rating(:user_id => 2, :place_id => 3, :value => 4)
      Rating.add_rating(:user_id => 1, :place_id => 4, :value => 4.5)
      Rating.place_ids_with_highest_rating(2).size.should eq 2
    end

    it "Selects the right places" do
      Rating.add_rating(:user_id => 1, :place_id => 1, :value => 5)
      Rating.add_rating(:user_id => 1, :place_id => 2, :value => 5)
      Rating.add_rating(:user_id => 2, :place_id => 3, :value => 4)
      Rating.add_rating(:user_id => 1, :place_id => 4, :value => 4.5)
      Rating.place_ids_with_highest_rating(2).should eq [1, 2]
    end

    it "Selects the right places2" do
      Rating.add_rating(:user_id => 1, :place_id => 1, :value => 5)
      Rating.add_rating(:user_id => 1, :place_id => 2, :value => 5)
      Rating.add_rating(:user_id => 2, :place_id => 3, :value => 4)
      Rating.add_rating(:user_id => 1, :place_id => 4, :value => 4.5)
      Rating.place_ids_with_highest_rating(3).should eq [1, 2, 4]
    end
  end

end