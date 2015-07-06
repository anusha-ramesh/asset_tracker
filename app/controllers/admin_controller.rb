class AdminController < ApplicationController
	layout "user"
	before_filter :authenticate_user!
	before_filter :admin_authorize
	before_filter :set_cache_buster
	autocomplete :product, :asset_name, :full => true
	
	def index
    @products = Product.page params[:page]

	  if params[:search]
      @products = Product.where('asset_name LIKE ?', "%#{params[:search]}%").order("asset_name ASC").page params[:page]
    end
  end
 

    
end
