require_relative '../../spec/rspec_config'
require_relative '../../models/address'

puts "In address_spec"

describe "Address" do

  describe "add_address" do
    it "adds an address successfully" do
      expect do
        Address.add_address(:residential_complex_id => 1,
                            :street => 'Some street',
                            :street_number => 1,
                            )
      end.to change(Address, :count).by(1)
    end
  end

end