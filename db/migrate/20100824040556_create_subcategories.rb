class CreateSubcategories < ActiveRecord::Migration
  def self.up
    create_table :subcategories do |t|
	t.string :name
	t.string :category_id
	t.string :photoset_id
      t.timestamps
    end
  end

  def self.down
    drop_table :subcategories
  end
end
