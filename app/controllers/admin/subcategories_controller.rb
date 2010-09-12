class Admin::SubcategoriesController < ApplicationController

	def index
		@category = Category.find_by_id(params[:id])

		@subcategories = @category.subcategories
	end
end
