class AlterSubcategories < ActiveRecord::Migration
  def self.up
	change_column :subcategories, :category_id, :integer
  end

  def self.down
  end
end
