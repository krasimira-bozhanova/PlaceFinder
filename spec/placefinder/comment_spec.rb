require_relative '../spec_helper'

module PlaceFinder
  describe "Comment" do
    describe "add_comment" do
      it "adds a comment successfully" do
        expect do
          Comment.add_comment(:user_id => 1, :place_id => 1, :comment => "Great place!")
        end.to change(Comment, :count).by(1)
      end
    end

    describe "comments_of_place" do
      it "returns an emtpy array when no comments for a place " do
        Comment.comments_of_place(1).should eq []
      end

      it "returns a non-empty array when there are comments for a place " do
        comment = FactoryGirl.create(:comment1)
        Comment.comments_of_place(comment.place_id).should eq [comment]
      end

      it "works when there are more than one comment for a place" do
        comment1 = FactoryGirl.create(:comment1)
        comment2 = FactoryGirl.create(:comment2)
        Comment.comments_of_place(1).size.should eq 2
        Comment.comments_of_place(1).should eq [comment1, comment2]
      end
    end

    describe "validate_comment" do
      it "works with an empty comment" do
        Comment.validate_comment("").should eq false
      end

      it "works with correct non-empty comment" do
        Comment.validate_comment("a").should eq true
      end

      it "works with whitespace" do
        Comment.validate_comment("   ").should eq false
      end
    end
  end
end