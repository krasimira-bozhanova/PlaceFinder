class CreateFavourites < ActiveRecord::Migration
  def up
    create_table :favourites do |t|
      t.integer :user_id,      :null => false
      t.integer :place_id,     :null => false
    end
  end

  def down
    drop_table :favourites
  end
end