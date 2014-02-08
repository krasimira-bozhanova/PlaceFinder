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

  describe 'address_by_place_id' do
    it 'returns the address successfully is exists' do
      address = FactoryGirl.create(:address)
      Address.address_by_place_id(address.place_id).should eq address
    end

    it 'returns nil is there is no address for this place' do
      Address.address_by_place_id(1).should eq nil
    end
  end

  describe 'add_place_id_to_address' do
    it 'adds an id successfully' do
      address = FactoryGirl.create(:address)
      Address.add_place_id_to_address(1, address.id)
      Address.address_by_place_id(1).should eq address      
    end

    it 'fails to adds a place_id when this field is already set' do
      address = FactoryGirl.create(:address1)
      Address.add_place_id_to_address(2, address.id)
      Address.address_by_place_id(2).should eq nil      
    end
  end

  describe 'address_id' do
    it 'returns the right address id if there is such an address' do
      address = FactoryGirl.create(:address1)
      Address.address_id(:residential_complex_id => address.residential_complex_id,
                         :street => address.street,
                         :street_number => address.street_number).should eq address.id
    end

    it 'returns nil if there is no such address' do
      Address.address_id(:residential_complex_id => 1,
                         :street => "Street",
                         :street_number => 1).should eq nil
    end
  end

end