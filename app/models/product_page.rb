require "net/http"
require "uri"
class ProductPage< Page
	description %{
		A product page lists all subcategories and their included brands
	}
  
  def cache?
    false
  end
  
  def child_url(child)
    clean_url "#{ url }/"
     
  end

  def find_by_url(url, live = true, clean = false)
   
    url = clean_url(url) if clean
    if url =~ %r{^#{ self.url }(\d{1,6})/brands/?$}
      children.find_by_class_name('BrandsPage')
    else
      super
    end
  end
  
  def category
    id = $1 if request_uri =~ %r{^#{self.url}(\d{1,6})/?$}
    
    category = Category.find_by_id(id)
    
  end
  
  def photoset_id
    category.photoset_id
  end

 
  tag "photoset_id" do |tag|
    photoset_id
  end
  
  tag "name" do |tag|
    category.name
  end

  
  
	tag "products" do |tag|
	
		subcategories = category.subcategories.find(:all, :order => :name)
    
		result = []
    
		subcategories.each do |subcategory|
        
			tag.locals.data = subcategory
      
			result << tag.expand
		end
		result
	end


	
		
	tag "subcategory_name" do |tag|
		tag.locals.data.name
	end

	tag "image" do |tag|
		output = ''
		
		url = "http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&photoset_id=#{photoset_id}+&api_key=6f977fc52e81b8f45764d91ab84999c2&format=json&nojsoncallback=1"	
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
		brands = tag.locals.data.brands.find(:all, :order => :name)

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
		%{<a target="_blank" href="#{tag.locals.data.website}">#{tag.locals.data.name}</a>}
	end
	
	tag "brand_more" do |tag|
   
    limit = tag.attr['limit'].to_i
    
    if tag.locals.data.brands.count > limit 
		  
			%{<a target="_blank" href="#{self.url}#{tag.locals.data.id}/brands">More...</a>}
      
    end
	end

	def init
    
  end

end

