class Subcategory < ActiveRecord::Base
	has_and_belongs_to_many :brands, :order => 'name'
	belongs_to :category
end
