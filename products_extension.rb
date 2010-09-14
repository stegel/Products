# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class ProductsExtension < Radiant::Extension
  version "1.0"
  description "Display a list of product subcategories with a rotating image"
  url "http://yourwebsite.com/products"

  
  def activate
    # tab 'Content' do
    #   add_item "Products", "/admin/products", :after => "Pages"
    # end
	tab 'Manage Site' do
		add_item('Products','/admin/categories')
    add_item('Subcategories','/admin/subcategories')
    add_item('Brands','/admin/brands')
	end
	ProductPage
	CategoryPage
	Page.class_eval do
		include ProductTags
	end
  end
end
