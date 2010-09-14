class Admin::SubcategoriesController < ApplicationController

	def index
		@category = Category.find_by_id(params[:category_id])
    @subcategories = @category.subcategories
	end
  
  def show
    @subcategory = Subcategory.find_by_id(params[:id])
  end
  
  def new
    @subcategory = Subcategory.new
    @categories = Category.find(:all)
    @brands = Brand.find(:all)
  end
  
  def create
    @subcategory = Subcategory.new(params[:subcategory])
    
     
    respond_to do |format|
      if @subcategory.save!
        format.html { redirect_to(admin_subcategory_url(@subcategory), :notice => "Subcategory was successfully created.")}
        format.xml {render :xml => @subcategory, :status => :created, :location => @subcategory}
      else
        format.html { render :action => "new" }
        format.xml 
      end
    end
  end

  def edit
    @subcategory = Subcategory.find_by_id(params[:id])
    @categories = Category.find(:all)
    @brands = Brand.find(:all)
  end
  
  def update
    params[:subcategory][:brand_ids] ||= {}
    
    @subcategory = Subcategory.find(params[:id])
    
    respond_to do |format|
      if @subcategory.update_attributes(params[:subcategory])
        format.html { redirect_to(admin_subcategory_url(@subcategory), :notice => "Subcategory was successfully updated.")}
        format.xml { head :ok}
      end
    end
  end
end
