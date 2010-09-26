class AddCategoryFlickrId < ActiveRecord::Migration
  def self.up
    add_column :categories, :photoset_id, :string
    remove_column :subcategories, :photoset_id
  end

  def self.down
  end
end
