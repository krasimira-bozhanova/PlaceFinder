class CreatePictures < ActiveRecord::Migration
  def up
    create_table :pictures do |t|
      t.integer :place_id,   :null => false
      t.string  :picture_path
    end
  end

  def down
    drop_table :pictures
  end
end