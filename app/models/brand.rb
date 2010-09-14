class Brand < ActiveRecord::Base
	has_and_belongs_to_many :subcategories
  
  validates_format_of :website, :with => URI::regexp(%w(http https))

  
end
