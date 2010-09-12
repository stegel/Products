class Admin::CategoriesController < ApplicationController

	def index
		@categories = Category.find(:all)
	end


end
