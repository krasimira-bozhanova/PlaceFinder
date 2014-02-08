require_relative '../../spec/rspec_config'
require_relative '../../models/type'

puts "In type_spec"

describe "Type" do

  describe "add_type" do
    it "adds a type successfully" do
      expect do
        Type.add_type(:name => "cafe", :plural_name => "cafes")
      end.to change(Type, :count).by(1)
    end
  end
end