class ProductsController < ApplicationController
  layout "user"
  respond_to :js, :html
  before_filter :authenticate_user!
  before_filter :set_cache_buster
  before_filter :admin_authorize, only: [:new, :create]
  autocomplete :product, :asset_name
	def new
    @product = Product.new
	end
  
  def index

    @products = Product.page params[:page]


    if params[:search]
      @products = Product.where('asset_name LIKE ?', "%#{params[:search]}%").order("asset_name ASC").page params[:page]
    end

    if params[:sort] == "asc"
      @products = Product.order("asset_name ASC").page params[:page]
    end
    
    if params[:sort] == "desc"
      @products = Product.order("asset_name DESC").page params[:page]
    end

    if params[:sort] == "type_asc"
      @products = Product.includes(:product_type).order("product_types.asset_type ASC"). page params[:page]
    end

    if params[:sort] == "type_desc"
      @products = Product.includes(:product_type).order("product_types.asset_type DESC"). page params[:page]
    end
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

  def get_user
    @inventory = Inventory.find(params[:id])
    puts "......................"
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

  
  # def resolve_layout
  #   case action_name
  #     when "index"
  #     "user"
  #     when "new", "create"
  #     "admin"
  #   end
  # end

  
end
