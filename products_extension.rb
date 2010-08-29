# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class ProductsExtension < Radiant::Extension
  version "1.0"
  description "Display a list of product subcategories with a rotating image"
  url "http://yourwebsite.com/products"
  
  # extension_config do |config|
  #   config.gem 'some-awesome-gem
  #   config.after_initialize do
  #     run_something
  #   end
  # end

  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    # tab 'Content' do
    #   add_item "Products", "/admin/products", :after => "Pages"
    # end
	ProductPage
	CategoryPage
	Page.class_eval do
		include ProductTags
	end
  end
end
