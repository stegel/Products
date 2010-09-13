# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class ProductsExtension < Radiant::Extension
  version "1.0"
  description "Display a list of product subcategories with a rotating image"
  url "http://yourwebsite.com/products"
  

   define_routes do |map|
    
    map.namespace :admin do |admin|
      admin.resources :categories, :has_many => :subcategories
  	  admin.resources :subcategories, :has_and_belongs_to_many => :brands
      admin.resources :brands, :has_and_belongs_to_many => :subcategories
	  end

   
	
	
  end
  
  def activate
    # tab 'Content' do
    #   add_item "Products", "/admin/products", :after => "Pages"
    # end
	tab 'Manage Site' do
		add_item('Products','/admin/categories')
	end
	ProductPage
	CategoryPage
	Page.class_eval do
		include ProductTags
	end
  end
end
