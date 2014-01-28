class CreateAddresses < ActiveRecord::Migration
  def up
    create_table :addresses do |t|
      t.string  :zhk,           :null => false
      t.string  :street,        :null => false
      t.integer :street_number, :null => false
      t.integer :place_id
    end
  end

  def down
    drop_table :addresses
  end
end