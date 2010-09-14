ActionController::Routing::Routes.draw do |map|
  # map.namespace :admin, :member => { :remove => :get } do |admin|
  #   admin.resources :products
  # end
  map.namespace :admin do |admin|
    admin.resources :categories, :has_many => :subcategories
    admin.resources :subcategories, :has_many => :brands, :has_and_belongs_to_many => :brands
    admin.resources :brands, :has_many => :subcategories,:has_and_belongs_to_many => :subcategories
  end
end