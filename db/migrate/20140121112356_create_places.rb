class CreatePlaces < ActiveRecord::Migration
  def up
    create_table(:places) do |t|
      t.string   :name,                   :null => false
      t.text     :description
      t.integer  :type_id,                :null => false
      t.float    :user_rating
      t.integer  :address_id,             :null => false
      t.datetime :date,                   :null => false
      t.integer  :residential_complex_id, :null => false
      t.string   :main_picture_path,      :null => false
    end
  end

  def down
    drop_table :places
  end

end