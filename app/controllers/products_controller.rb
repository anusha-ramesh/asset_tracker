class ProductsController < ApplicationController
  layout :resolve_layout
  respond_to :js, :html
  before_filter :authenticate_user!
  before_filter :set_cache_buster
  before_filter :admin_authorize, only: [:new, :create, :destroy]
  autocomplete :product, :asset_name, :full => true
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
      render action: "show"
    else
      # flash[:alert] = "Fields require!"
    	render action:"new"
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def get_user
    @inventory = Inventory.find(params[:id])
    # render :layout => false 
  end

  def update_user
    @inventory = Inventory.find(params[:id])
    @user = User.find_by_email(params[:email])
    if @user == nil
      flash[:alert] = "Not a valid user!"
    else
      @inventory.user_id = @user.id
      @inventory.update_attributes params[:inventory]
      UserMailer.asset_request(@user,current_user,@inventory).deliver!
    end
  end

  def user_asset_release
    render :layout => false 
    @inventory = Inventory.find(params[:id])
    @user = User.find_by_email(params[:email])
    UserMailer.asset_release(@user,current_user,@inventory).deliver!
  end

  def asset_to_shelf
    @inventory = Inventory.find(params[:id])
    @inventory.user_id = nil
    @inventory.update_attributes params[:inventory]
    UserMailer.back_to_shelf(current_user,@inventory).deliver!
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @product = @inventory.product
    if @inventory.destroy
      if @product.inventories.empty?
        @product.destroy
      end
    end
    
  end


  private

  def product_params
    {
      :asset_name => params[:product][:asset_name],
      :image => params[:product][:image],
      :product_type_id => params[:product][:product_type_id],
      :inventories_attributes => params[:product][:inventories_attributes]
    }
  end

  
  def resolve_layout
    case action_name
      when "index", "new", "create", "show", "update_user"
        "user"
      # when "get_user"
      #   "application"
    end
  end

  
end
