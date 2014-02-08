require_relative '../../spec/rspec_config'
require_relative '../../models/picture'

module PlaceFinder
  describe "Picture" do
    describe "add_picture" do
      it "adds a picture successfully" do
        expect do
          Picture.add_picture(:place_id => 1, :picture_path => "picture.png")
        end.to change(Picture, :count).by(1)
      end
    end

    describe "pictures_for_place" do
      it "returns an emtpy array when no pictures for a place " do
        Picture.pictures_for_place(1).should eq nil
      end

      it "returns a non-empty array when there are pictures for a place " do
        picture = FactoryGirl.create(:picture1)
        Picture.pictures_for_place(1).should eq [picture]
      end

      it "works when there is more than one picture for a place" do
        picture1 = FactoryGirl.create(:picture1)
        picture2 = FactoryGirl.create(:picture1_2)
        Picture.pictures_for_place(1).should eq [picture1, picture2]
      end

      it "works when there are different pictures for different places" do
        picture1 = FactoryGirl.create(:picture1)
        picture2 = FactoryGirl.create(:picture2)
        Picture.pictures_for_place(1).should eq [picture1]
        Picture.pictures_for_place(2).should eq [picture2]
      end
    end
  end
end