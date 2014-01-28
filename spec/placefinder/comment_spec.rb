require_relative '../../spec/rspec_config'
require_relative '../../models/comment'

puts "In comment_spec"

describe "Comment" do

  describe "add_comment" do
    it "adds a comment successfully" do
      expect do
        Comment.add_comment(:user_id => 1, :place_id => 1, :comment => "Great place!")
      end.to change(Comment, :count).by(1)
    end
  end

  describe "get_comments_of_place" do
    it "returns an emtpy array when no comments for a place " do
      Comment.get_comments_of_place(1).should eq []
    end
  end

  describe "get_comments_of_place" do
    it "returns a non-empty array when there are comments for a place " do
      Comment.add_comment(:user_id => 1, :place_id => 1, :comment => "Great place!")
      Comment.get_comments_of_place(1).should eq [{"id"=>1, "place_id"=>1, "user_id"=>1, "comment"=>"Great place!"}]
    end
  end

end