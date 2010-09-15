ActionController::Routing::Routes.draw do |map|
  # map.namespace :admin, :member => { :remove => :get } do |admin|
  #   admin.resources :products
  # end
  map.namespace :admin do |admin|
    admin.resources :categories, :has_many => :subcategories
	admin.resources :subcategories do |subcategories|
		subcategories.resources :brands
	end

	admin.resources :brands do |brands|
		brands.resources :subcategories
	end
  end
end
