class ProductPage< Page
	description %{
		A product page lists all subcategories and their included brands
	}

	tag "products" do |tag|
		category = $1 if request_uri =~ %r{^#{self.url}(\d{1,6})/?$}
		
		subcategories = Subcategory.find(:all, :conditions => "category_id = #{category}")
		result = []
		subcategories.each do |subcategory|
			tag.locals.data = subcategory
			result << tag.expand
		end
		result
	end

	tag "category" do |tag|
		category = $1 if request_uri =~ %r{^#{self.url}(\d{1,6})/?$}

		category = Category.find_by_id(category)

		category.name
	end

	tag "subcategory_name" do |tag|
		tag.locals.data.name
	end

	tag "image" do |tag|
		output = ''
		
		url = "http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&photoset_id=#{tag.locals.data.photoset_id}+&api_key=6f977fc52e81b8f45764d91ab84999c2&format=json&nojsoncallback=1"	
		json = Net::HTTP.get(URI.parse(url))

		result = ActiveSupport::JSON.decode(json)

		unless result['stat'] == "fail"	
			set = result['photoset']['photo']
			
			unless set.empty?
				set[0..set.length-1].each do |photo|
					if photo['title'].downcase == tag.locals.data.name.downcase
						thumb = "http://farm#{photo['farm']}.static.flickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}_t.jpg"
						output += %{<img src="#{thumb}" alt="#{photo['title']}" />}

					end
				end
			end
		end
		output
	end

	tag "brands" do |tag|
		brands = tag.locals.data.brands

		result = []
		
		limit = tag.attr['limit'].to_i

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

