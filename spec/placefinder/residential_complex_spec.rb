require_relative '../../spec/rspec_config'
require_relative '../../models/residential_complex'

puts "In residential_complex_spec"

describe "ResidentialComplex" do

  describe "add_residential_complex" do
    it "adds a residential_complex successfully" do
      expect do
        ResidentialComplex.add_residential_complex(:name => "Izgrev")
      end.to change(ResidentialComplex, :count).by(1)
    end
  end

  describe "residential_complex_name_by_id" do
    it "gets the name if the residential_complex with this id exists" do
      residential_complex = FactoryGirl.create(:residential_complex)
      ResidentialComplex.residential_complex_name_by_id(1).should eq residential_complex.name
    end

    it "returns nil if there is no such residential_complex" do
      ResidentialComplex.residential_complex_name_by_id(1).should eq nil
    end
  end
end