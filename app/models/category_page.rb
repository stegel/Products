require "net/http"
require "uri"
class CategoryPage < Page

	desc %{
		list all categories with links to subcategory page
	}
  def child_url(child)
	

    clean_url "#{ url }/"
  end

  def find_by_url(url, live = true, clean = false)
    url = clean_url(url) if clean
    if url =~ %r{^#{ self.url }(\d{1,6})/?$}
      children.find_by_class_name('ProductPage')
    else
      super
    end
  end
  
  tag "a_photo" do |tag|
    output = ''
    
    url = "http://api.flickr.com/services/rest/?method=flickr.collections.getTree&collection_id=72157624659199715&api_key=6f977fc52e81b8f45764d91ab84999c2&format=json&nojsoncallback=1&user_id=52768084@N06"
    
    json = Net::HTTP.get(URI.parse(url))

    result = ActiveSupport::JSON.decode(json)
    
    unless result['stat'] == "fail" 
      set = result['collections']['collection'][0]['set']
      index = rand(set.length)
      
      photoset_id = set[index]['id']
      
      set_url = "http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&photoset_id=#{photoset_id}&api_key=6f977fc52e81b8f45764d91ab84999c2&format=json&nojsoncallback=1"
      
      json = Net::HTTP.get(URI.parse(set_url))

      result = ActiveSupport::JSON.decode(json)
    
      unless result['stat'] == "fail" 
        photoset = result['photoset']['photo']
        photo = photoset[rand(photoset.length)]
        src = "http://farm#{photo['farm']}.static.flickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}_m.jpg"
       
        output = "<img src=#{src} alt='Random Photo' />"
      end
    end
    
    
    
  end
end

