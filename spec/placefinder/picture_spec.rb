require_relative '../../spec/rspec_config'
require_relative '../../models/picture'

puts "In picture_spec"

describe "Picture" do

  describe "add_picture" do
    it "adds a picture successfully" do
      expect do
        Picture.add_picture(:place_id => 1, :picture_path => "picture.png")
      end.to change(Picture, :count).by(1)
    end
  end

  describe "get_pictures_for_place" do
    it "returns an emtpy array when no pictures for a place " do
      Picture.get_pictures_for_place(1).should eq []
    end

    it "returns a non-empty array when there are pictures for a place " do
      Picture.add_picture(:place_id => 1, :picture_path => "picture.png")
      Picture.get_pictures_for_place(1).should eq [{"id"=>1, "place_id"=>1, "picture_path"=>"picture.png"}]
    end

    it "works when there are more than one picture for a place" do
      Picture.add_picture(:place_id => 1, :picture_path => "picture1.png")
      Picture.add_picture(:place_id => 1, :picture_path => "picture2.png")
      Picture.get_pictures_for_place(1).size.should eq 2
    end
  end

end