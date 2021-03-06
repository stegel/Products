class Category < ActiveRecord::Base
	has_many :subcategories
  
  def photosets
    output = []

    json = Net::HTTP.get(URI.parse("http://api.flickr.com/services/rest/?method=flickr.collections.getTree&collection_id=72157624659199715&api_key=6f977fc52e81b8f45764d91ab84999c2&format=json&nojsoncallback=1&user_id=52768084@N06"))
    
    result = ActiveSupport::JSON.decode(json)
    unless result['stat'] == "fail" 
      sets = result['collections']['collection'][0]['set']

      sets.each do |set|
        output << {"id" => set['id'], "title" => set['title']}
      end
    end
    
    output
  end
  
  def photoset
    url = "http://api.flickr.com/services/rest/?method=flickr.photosets.getInfo&photoset_id=#{self.photoset_id}+&api_key=6f977fc52e81b8f45764d91ab84999c2&format=json&nojsoncallback=1&user_id=52768084@N06"
    json = Net::HTTP.get(URI.parse(url))
    
    result = ActiveSupport::JSON.decode(json)
    unless result['stat'] == "fail" 
      set = result['photoset']
      set['title'].to_s.sub("_content","")
    end
   
  end
  
end
