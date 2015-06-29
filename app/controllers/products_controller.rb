class ProductsController < ApplicationController
  layout "user"
  respond_to :js, :html
  before_filter :authenticate_user!
  before_filter :set_cache_buster
  before_filter :admin_authorize, only: [:new, :create]

	def new
    @product = Product.new
	end
  
  def index
    @products = Product.all
  end

	def create
    @product = Product.new(product_params)
    if @product.save
      if(current_user.user_name == "admin")
        redirect_to admin_index_path
      else
    	  redirect_to root_path
      end
    else
      flash[:alert] = "Fields require!"
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

  
end
