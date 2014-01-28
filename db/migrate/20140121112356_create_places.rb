class CreatePlaces < ActiveRecord::Migration
  def up
    create_table(:places) do |t|
      t.string  :name,         :null => false
      t.text    :description
      t.integer :type_id,     :null => false
      t.string  :user_rating
    end
  end

  def down
    drop_table :places
  end
end