class CreatePictures < ActiveRecord::Migration
  def up
    create_table :pictures do |t|
      t.integer :place_id,   :null => false
      t.binary  :picture
    end
  end

  def down
    drop_table :pictures
  end
end