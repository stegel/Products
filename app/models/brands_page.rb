class BrandsPage< Page
  
  tag "product" do |tag|
    category = $1 if request_uri =~ %r{^#{self.url}(\d{1,6})/brands/?$}
    
    subcategories = Subcategory.find(:all, :conditions => "category_id = #{category}", :order => :name)
    result = []
    subcategories.each do |subcategory|
      tag.locals.data = subcategory
      result << tag.expand
    end
    result
  end
  
  tag "brands" do |tag|
    id = $1 if request_uri =~ %r{^#{self.url}(\d{1,6})/brands/?$}

	subcategory = Subcategory.find(:all, :conditions => "id = #{id}", :order => :name)
	
	brands = subcategory[0].brands
	
    result = []
    
    
    limit = tag.attr['limit'].to_i

	if !limit
		limit = 15
	end
	
    brands[0..limit-1].each do |brand|
      tag.locals.data = brand
      result << tag.expand
    end
    result
  end

  tag "brand_name" do |tag|
    tag.locals.data.name
  end

  tag "brand_link" do |tag|
    %{<a href="#{tag.locals.data.website}">#{tag.locals.data.name}</a>}
  end
end