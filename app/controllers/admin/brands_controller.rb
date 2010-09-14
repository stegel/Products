class Admin::BrandsController < ApplicationController
  
  def index
    if params[:subcategory_id]
      @subcategory = Subcategory.find_by_id(params[:subcategory_id])
      
      render "admin/subcategories/show"
      
    else
      @brands = Brand.find(:all)
      
      if @brands.empty?
        redirect_to :new_admin_brand
      end      
    end
  end
  
  def show
    @brand = Brand.find_by_id(params[:id])
  end
  
  def new
    @brand = Brand.new
    
    if params[:subcategory_id]
      @brand.subcategory_ids = params[:subcategory_id]
    end
    @subcategories = Subcategory.find(:all)
  end
  
  def edit
    @brand = Brand.find_by_id(params[:id])
    @subcategories = Subcategory.find(:all)
  end
  
  def create
    @brand = Brand.new(params[:brand])
    
    if @brand.save
      flash[:notice] = "Brand was successfully created"
      redirect_to(admin_brand_url(@brand))
    else
      @subcategories = Subcategory.find(:all)
      render :new
    end
  end
  
  def update
    params[:brand][:subcategory_ids] ||= {}
    
    @brand = Brand.find(params[:id])
     
    respond_to do |format|
      if @brand.update_attributes(params[:brand])
        format.html { redirect_to(admin_brand_url(@brand), :notice => "Category was successfully updated.")}
        format.xml { head :ok}
      end
    end
  end
  
  def destroy
    if(params[:subcategory_id])
      subcategory = Subcategory.find(params[:subcategory_id])
      respond_to do |format|
        if subcategory.brands.delete(Brand.find(params[:id]))
          format.html { redirect_to(admin_subcategory_url(subcategory), :notice => "Brand was successfully removed.")}
          format.xml { head :ok}
        end
      end
    else
      brand = Brand.find(params[:id])
      respond_to do |format|
        if brand.delete
          format.html { redirect_to(admin_brands_url, :notice => "Brand was successfully removed.")}
          format.xml { head :ok}
        end
      end
    end
  end
  

  
end
