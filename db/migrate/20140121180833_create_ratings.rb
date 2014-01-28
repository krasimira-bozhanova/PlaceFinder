class CreateRatings < ActiveRecord::Migration
  def up
    create_table :ratings do |t|
      t.integer :place_id, :null => false
      t.integer :user_id,  :null => false
      t.float   :value,    :null => false
    end
  end

  def down
    drop_table :ratings
  end
end