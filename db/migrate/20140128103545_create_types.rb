class CreateTypes < ActiveRecord::Migration
  def up
    create_table :types do |t|
      t.string  :name,         :null => false
      t.string  :plural_name,  :null => false
    end
  end

  def down
    drop_table :types
  end
end