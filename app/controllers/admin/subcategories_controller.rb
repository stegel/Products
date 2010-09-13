class Admin::SubcategoriesController < ApplicationController

	def index
		@category = Category.find_by_id(params[:category_id])
    @subcategories = @category.subcategories
	end
  
  def show
    @subcategory = Subcategory.find_by_id(params[:id])
    
  end
end
