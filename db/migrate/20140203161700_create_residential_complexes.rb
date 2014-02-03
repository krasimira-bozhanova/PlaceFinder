class CreateResidentialComplexes < ActiveRecord::Migration
  def up
    create_table :residential_complexes do |t|
      t.string  :name,  :null => false
    end
  end

  def down
    drop_table :residential_complexes
  end
end