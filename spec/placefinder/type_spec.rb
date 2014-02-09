require_relative '../spec_helper'

module PlaceFinder
  describe "Type" do
    describe "add_type" do
      it "adds a type successfully" do
        expect do
          Type.add_type(:name => "cafe", :plural_name => "cafes")
        end.to change(Type, :count).by(1)
      end
    end

    describe "type_name_by_id" do
      it "gets the name if the type with this id exists" do
        type = FactoryGirl.create(:type_restaurant)
        Type.type_name_by_id(1).should eq type.name
      end

      it "returns nil if there is no such type" do
        Type.type_name_by_id(1).should eq nil
      end
    end

    describe "type_plural_name_by_id" do
      it "gets the plural name if the type with this id exists" do
        type = FactoryGirl.create(:type_restaurant)
        Type.type_plural_name_by_id(1).should eq type.plural_name
      end

      it "returns nil if there is no such type" do
        Type.type_plural_name_by_id(1).should eq nil
      end
    end
  end
end