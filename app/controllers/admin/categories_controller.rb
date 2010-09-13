class Admin::CategoriesController < ApplicationController

	def index
		@categories = Category.find(:all)
  end

  def show
    @category = Category.find_by_id(params[:id])
  end

  def edit
    @category = Category.find_by_id(params[:id])
  end

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])
    
    respond_to do |format|
      if @category.save!
        format.html { redirect_to(admin_category_url(@category), :notice => "Category was successfully created.")}
        format.xml {render :xml => @category, :status => :created, :location => @category}
      else
        format.html { render :action => "new" }
        format.xml 
      end
    end
  end
  
  def update
    @category = Category.find(params[:id])
     
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(admin_category_url(@category), :notice => "Category was successfully updated.")}
        format.xml { head :ok}
      end
     end
  end
  
end
