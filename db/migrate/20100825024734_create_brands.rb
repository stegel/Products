class CreateBrands < ActiveRecord::Migration
  def self.up
    create_table :brands do |t|
	t.string :name
	t.string :website
      t.timestamps
    end

	create_table :brands_subcategories, :id => false do |t|
		t.integer :subcategory_id
		t.integer :brand_id
	end
  end

  def self.down
    drop_table :brands
  end
end
