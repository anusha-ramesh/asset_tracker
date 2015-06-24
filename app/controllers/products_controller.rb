class ProductsController < ApplicationController
  respond_to :js, :html
	def new
    @product = Product.new
	end

	def create
    @product = Product.new(product_params)
    if @product.save
    	redirect_to root_path
    else
    	redirect_to new_product_path
    end
  end

  private

  def product_params
  	#params.require(:product).permit(:asset_name, :image, :ProductType_id, :inventories_attributes => []) 
    {
      :asset_name => params[:product][:asset_name],
      :image => params[:product][:image],
      :product_type_id => params[:product][:product_type_id],
      :inventories_attributes => params[:product][:inventories_attributes]
    }
  end

  def index
    @products = Product.all
  end
end
