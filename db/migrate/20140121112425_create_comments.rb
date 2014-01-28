class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.integer :place_id, :null => false
      t.integer :user_id,  :null => false
      t.text    :comment,  :null => false
    end
  end

  def down
    drop_table :comments
  end
end