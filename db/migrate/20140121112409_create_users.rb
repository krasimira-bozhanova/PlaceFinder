class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string  :username,   :null => false
      t.string  :name,       :null => false
      t.string  :password,   :null => false
      t.boolean :login,      :null => false
      t.boolean :admin,      :null => false
    end
  end

  def down
    drop_table :users
  end
end